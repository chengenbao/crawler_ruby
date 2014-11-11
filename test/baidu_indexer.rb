#!/usr/bin/env ruby

filename = File.dirname(__FILE__) + "/../config/application.rb"
require "#{File.expand_path(filename)}"

pages = Page.where(:indexed=>3).limit(100)

pages.each do |page|
  f = open("data/#{page.sum}.html", "w")
  f.write page.page
  f.close
end
