#!/usr/bin/env ruby

filename = File.dirname(__FILE__) + "/config/application.rb"
require "#{File.expand_path(filename)}"

config = Application.config

qihu_spider = Spider::Qihu.new config.qihu_spider_number, config.spider_min_sleep_time, config.spider_max_sleep_time
baidu_spider = Spider::Baidu.new config.baidu_spider_number, config.spider_min_sleep_time, config.spider_max_sleep_time
qihu_indexer = Indexer::Qihu.new config.qihu_indexer_number, config.indexer_min_sleep_time, config.indexer_max_sleep_time, config.qihu_indexer_match_reg
baidu_indexer = Indexer::Baidu.new config.baidu_indexer_number, config.indexer_min_sleep_time, config.indexer_max_sleep_time

qihu_spider.start
baidu_spider.start

qihu_indexer.start
baidu_indexer.start

# loop forever
while true
  sleep 30
end


