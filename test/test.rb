#!/usr/bin/env ruby

t = Thread.new do 
  i = 1
  while i > 0
    puts i
    sleep 1
    i += 1
  end
end

t.join 

puts "hello"
