#!/usr/bin/env ruby

module Spider
  class Qihu < Spider
    def self.instruction
      puts "I am 360 spider"
    end

    def initialize( worker_count, min_sleep_time, max_sleep_time)
      super worker_count, min_sleep_time, max_sleep_time
      @url = "http://www.so.com/s?ie=utf-8&shb=1&src=360sou_newhome"
      @unindexed_tag = 0
      @uncrawled_tag = 0
      @crawled_tag = 1
      @name = "qihu"
    end
  end
end
