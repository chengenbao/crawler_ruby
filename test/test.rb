#!/usr/bin/env ruby

filename = File.dirname(__FILE__) + "/../config/application.rb"
require "#{File.expand_path(filename)}"

spider = Spider::Qihu.new Application.config.qihu_spider_number, Application.config.min_sleep_time, Application.config.max_sleep_time
spider.start
