#!/usr/bin/env ruby

module Indexer
  class Baidu < Indexer
    def initialize( worker_count, min_sleep_time, max_sleep_time)
      super worker_count, min_sleep_time, max_sleep_time

      @unindexed_tag = 3
      @indexed_tag = 4
      @name = "baidu indexer"
    end

    def index(page, word)
      page = page.gsub('<em>', '')
      page = page.gsub('</em>', '')
      page = page.gsub('<font>', '')
      page = page.gsub('</font>', '')

      begin
        reg = /<a\s+data-click="[^<>]+"\s+>([^<>]+)<\/a>/
        match = page.scan reg
        indexes = []

        match.each do |m|
          index = Index.new
          index.title = m[0]
          index.word = word
          indexes << index
        end


        reg = /<span class="g">(\w[\.\w]+\/*)[^<>]+<\/span>/
        match = page.scan reg
        i = 0
        match.each do |m|
          indexes[i].url = m[0]
          sum = Digest::SHA1.hexdigest "#{indexes[i].title}--#{m[0]}--#{indexes[i].word}"
          indexes[i].sum = sum
          i += 1
        end
      rescue Exception => e
        Util.log "Baidu Indexer exception caught"
      end

      indexes.each do |index|
        begin
          index.save
        rescue Exception => e
          Util.log "can not write index --> title:#{index.title},url:#{index.url}"
        end
      end
    end

  end

end
