#!/usr/bin/env ruby

module Model
  dirname = "#{File.dirname(__FILE__)}/model"

  Dir.glob("#{dirname}/*.rb").each do |filename|
    require filename
  end
end
