#!/usr/bin/env ruby

filename = File.dirname(__FILE__) + "/../config/application.rb"
require "#{File.expand_path(filename)}"
require 'json'

requester = Util::HttpRequester.new

f = open(File.dirname(__FILE__) + "/../data/cities")

while line = f.gets
  city_name = line.chop
  puts city_name

  item = City.where(:name=>city_name).limit(1)
  if item.length == 0
    fields = {}
    fields['query'] = city_name
    data = requester.get 'http://www.daodao.com/TypeAheadJson?action=GEO', fields
    data = data.gsub 'while(1);', ''
    array = JSON.parse data
    array.each do |city|
      if city['name'].index city_name
        City.create :name=>city_name, :geo=>city["value"]
      end
    end
  end
end

