#!/usr/bin/env ruby

require 'digest/sha1'

require "#{File.dirname(__FILE__)}/util.rb"
require "#{File.dirname(__FILE__)}/models.rb"

module Spider
  #common spider
  class Spider < Util::Robot
    # get word from database
    def get_word
      begin
        item = Word.where(:crawled => @uncrawled_tag).limit(1)
      rescue Exception => e
        Util.log "cannot get a word"
      end

      if item && item.length > 0
        return item[0]
      else
        return nil
      end
    end

    # crawl page
    def crawl_page(field)
      if not @requester
        @requester = Util::HttpRequester.new
      end

      begin
        page = @requester.get(@url, field)
      rescue Exception => e
        page = nil
        Util.log "requester exception"
      end

      return page
    end

    def save_page(page, word)
      if page
        begin
          # 计算sha1摘要
          sum = Digest::SHA1.hexdigest page
          Page.create :page=>page, :word=>word, :sum=>sum, :indexed=>@unindexed_tag
        rescue Exception => e
          Util.log "can not save page!"
        end
      end

    end

    # job
    def job
      while not @stopped
        # random sleep
        time = Random.rand(@max_sleep_time) + @min_sleep_time
        word_item = get_word
        if word_item
          sleep time
          word = word_item.word

          Util.log "#{@name} crawl #{word}"
          field = {}
          field["wd"] = word
          field["ie"] = "utf-8"
          page = crawl_page(field)
          save_page(page, word)

          #save word
          if page
            begin
              word_item.crawled = @crawled_tag
              word_item.save
            rescue Exception => e
              Util.log "exception found!"
            end
          end
        else
          Util.log "baidu no words to crawl"
          sleep time * 2
        end
      end
    end

  end

  dirname = "#{File.dirname(__FILE__)}/spider"
  Dir.glob("#{dirname}/*.rb").each do |filename|
    require filename
  end
end
