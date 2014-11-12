#!/usr/bin/env ruby

require "#{File.dirname(__FILE__)}/util.rb"
require "#{File.dirname(__FILE__)}/models.rb"

module Indexer
  class Indexer < Util::Robot
    def index(page, word)
      #do something indexed the page
    end

    def get_page
      begin
        item = Page.where(:indexed => @unindexed_tag).limit(1)
      rescue Exception => e
        Util.log "Can not get page to be indexed"
      end

      if item && item.length > 0
        return item[0]
      else
        return nil
      end
    end

    def save_page(page)
      begin
        page.indexed = @indexed_tag
        page.save
      rescue Exception => e
        Util.log "can not save index page"
      end
    end

    def job
      while not @stopped
        time = Random.rand(@max_sleep_time) + @min_sleep_time
        sleep time

        Util.log @name
        page = get_page
        if page
          index page.page, page.word # index the page
          save_page page
        end
      end 
    end

  end # class end

  dirname = "#{File.dirname(__FILE__)}/indexer"

  Dir.glob("#{dirname}/*.rb").each do |filename|
    require filename
  end
end
