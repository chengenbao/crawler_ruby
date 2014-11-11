#!/usr/bin/env ruby

require "#{File.dirname(__FILE__)}/util.rb"
require "#{File.dirname(__FILE__)}/models.rb"

module Spider
  dirname = "#{File.dirname(__FILE__)}/spider"
  Dir.glob("#{dirname}/*.rb").each do |filename|
    require filename
  end
end
