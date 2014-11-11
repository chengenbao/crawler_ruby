#!/usr/bin/env ruby

require 'digest/sha1'

module Spider
  class Qihu
    URL = "http://www.so.com/s?ie=utf-8&shb=1&src=360sou_newhome"
    CRAWL_TAG = 1
    UNINDEX_TAG = 0


    def self.instruction
      puts "I am 360 spider"
    end

    def initialize( worker_count, min_sleep_time, max_sleep_time)
      @worker_count = worker_count
      @requester = Util::HttpRequester.new
      @min_sleep_time = min_sleep_time
      @max_sleep_time = max_sleep_time
    end

    def start()
      @stopped = false

      @threads = []
      i = 0
      while (i < @worker_count)
        t = Thread.new do
          crawl_data
        end
        i+=1

        @threads << t
      end

      while not @stopped #loop forever
        sleep 30
      end
    end

    def stop
      @stopped = true
    end

    private
    def crawl_data
      while not @stopped
        # random sleep
        time = Random.rand(@max_sleep_time) + @min_sleep_time

        begin
          item = Word.where(:crawled=>0).limit(1)
        rescue Exception => e
          Util.log "error connection to database"
        end

        if item && item.length > 0
          sleep time
          item  = item[0]
          word = item[:word]

          Util.log "#{word}"
          field = {}
          field["q"] = word
          data = @requester.get URL, field

          if data
            begin
              item.crawled = CRAWL_TAG
              item.save

              # 计算SHA1摘要
              sum = Digest::SHA1.hexdigest data
              Page.create :page=>data, :sum=>sum, :indexed=>UNINDEX_TAG
            rescue Exception => e
              puts e
              Util.log "Exception found!"
            end
          end
          
        else
          sleep 1
          Util.log "no words to crawl"
        end
      end
    end
  end
end
