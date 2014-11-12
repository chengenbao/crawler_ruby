#!/usr/bin/env ruby

module Spider
  class Baidu < Spider
    def initialize( worker_count, min_sleep_time, max_sleep_time)
      super worker_count, min_sleep_time, max_sleep_time
      @url = "http://www.baidu.com/s"
      @unindexed_tag = 3
      @uncrawled_tag = 1
      @crawled_tag = 2
      @name = "baidu"
    end

    def self.instruction
      puts "I am baidu spider"
    end
  end
end
