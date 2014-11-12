#!/usr/bin/env ruby

module Indexer
  class Baidu
    UNINDEX_TAG = 3
    INDEXED_TAG = 4

    def self.instruction
      puts "I am baider indexer"
    end

    def initialize(worker_count, min_sleep_time, max_sleep_time)
      @worker_count = worker_count
      @min_sleep_time = min_sleep_time
      @max_sleep_time = max_sleep_time
    end

    def start
      @stopped = false
      @threads = Util.newthreads(@worker_count, self, :process_page)
    end

    def stop
      @stopped = true
    end

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
          page = item.page

          page = page.gsub('<em>', '')
          page = page.gsub('</em>', '')
          page = page.gsub('<font>', '')
          page = page.gsub('</font>', '')

          reg = /<a\s+data-click="[^<>]+"\s+>([^<>]+)<\/a>/
          match = page.scan reg
          indexes = []

          match.each do |m|
            index = Index.new
            index.title = m[0]
            index.word = item.word
            indexes << index
          end


          reg = /<span class="g">(\w[\.\w]+\/*)[^<>]+<\/span>/
          match = page.scan reg
          i = 0
          match.each do |m|
            indexes[i].url = m[0]
            sum = Digest::SHA1.hexdigest "#{indexes[i].title}--#{m[0]}"
            indexes[i].sum = sum
            i += 1
          end

          indexes.each do |index|
            begin
            index.save
            rescue Exception => e
              Util.log "can not write index --> title:#{index.title},url:#{index.url}"
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
