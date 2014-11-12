#!/usr/bin/env ruby

filename = File.dirname(__FILE__) + "/config/application.rb"
require "#{File.expand_path(filename)}"

config = Application.config

qihu_spider = Spider::Qihu.new config.qihu_spider_number, config.spider_min_sleep_time, config.spider_max_sleep_time
baidu_spider = Spider::Baidu.new config.baidu_spider_number, config.spider_min_sleep_time, config.spider_max_sleep_time
qihu_indexer = Indexer::Qihu.new config.qihu_indexer_number, config.indexer_min_sleep_time, config.indexer_max_sleep_time
baidu_indexer = Indexer::Baidu.new config.baidu_indexer_number, config.indexer_min_sleep_time, config.indexer_max_sleep_time

qihu_spider.start
#baidu_spider.start

qihu_indexer.start
baidu_indexer.start

puts config.terminate_words_count

# loop forever
while true
  word_count = Word.all.count

  if word_count >= config.terminate_words_count
    qihu_indexer.stop
    baidu_indexer.stop

    qihu_spider.stop
    baidu_spider.stop

    break
  end
end

Util.log "We Stopped"


