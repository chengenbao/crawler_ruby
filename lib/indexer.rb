#!/usr/bin/env ruby

module Indexer
  dirname = "#{File.dirname(__FILE__)}/indexer"

  Dir.glob("#{dirname}/*.rb").each do |filename|
    require filename
  end
end
