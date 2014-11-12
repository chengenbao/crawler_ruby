#!/usr/bin/env ruby

module Indexer
  class Qihu < Indexer
    def self.instruction
      puts 'I am 360 indexer'
    end

    def initialize(worker_count, min_sleep_time, max_sleep_time)
      super worker_count, min_sleep_time, max_sleep_time

      @unindexed_tag = 0
      @indexed_tag = 2
      @name = "Qihu indexer"
    end

    def index(page, wd)
      pattern = /<th><a href="[^<>]+" data-type="0">([^<>]+)<\/a><\/th>/

      match = page.scan pattern
      match.each do |word|
        begin
          Word.create :word=>word[0], :crawled=>0
        rescue Exception => e
        end
      end
    end

  end
end
