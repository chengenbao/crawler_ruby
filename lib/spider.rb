#!/usr/bin/env ruby

module Spider
  dirname = "#{File.dirname(__FILE__)}/spider"
  Dir.glob("#{dirname}/*.rb").each do |filename|
    require filename
  end
end
