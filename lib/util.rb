#!/usr/bin/env ruby

###################################################################
#
# Filename: util.rb
#
# 工具模块，提供各种通用功能
# 
# Author: chengenbao
# Email: genbao.chen@gmail.com
#
###################################################################


module Util
  dirname = "#{File.dirname(__FILE__)}/util"

  Dir.glob("#{dirname}/*.rb").each do |filename|
    require filename
  end
end
