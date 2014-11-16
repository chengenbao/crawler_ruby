#!/usr/bin/env ruby

require './http_requester'

requester = Util::HttpRequester.new
body = requester.get 'http://baike.baidu.com/view/115772.htm?fr=aladdin', nil
reg = /<td width="149"[^<>]+><a target=_blank href="\/view\/\d+.htm">([^<>]+)<\/a>[^<>]*<\/td>/
match = body.scan reg
puts match
