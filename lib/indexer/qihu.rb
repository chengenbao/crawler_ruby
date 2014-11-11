#!/usr/bin/env ruby

module Indexer
  class Qihu
    UNINDEX_TAG = 0
    INDEXED_TAG = 2

    def self.instruction
      puts 'I am 360 indexer'
    end

    def initialize(worker_count, min_sleep_time, max_sleep_time, pattern)
      @worker_count = worker_count
      @min_sleep_time = min_sleep_time
      @max_sleep_time = max_sleep_time
      @pattern = pattern
    end

    def start
      @stopped = false
      @threads = []
      i = 0

      while i < @worker_count
        t = Thread.new do
          process_page
        end

        i += 1
        @threads << t
      end
    end

    def stop
      @stopped = true
    end

    private
    def process_page
      while not @stopped
        time = Random.rand(@max_sleep_time) + @min_sleep_time

        begin
          item = Page.where(:indexed => UNINDEX_TAG).limit(1)
        rescue Exception => e
          Util.log "Can not get page to be indexed"
        end

        if item && item.length > 0
          sleep time #random sleep
          item = item[0]
          page = item[:page]

          match = page.scan @pattern
          match.each do |word|
            begin
              Word.create :word=>word[0], :crawled=>0
            rescue Exception => e
            end
          end
          # save page
          begin
            item[:indexed] = INDEXED_TAG
            item.save
          rescue Exception => e
            Util.log "can not save index page"
          end

        end 

      end
    end

  end
end
