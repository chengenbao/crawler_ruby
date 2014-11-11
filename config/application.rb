require 'active_record'
require 'sqlite3'
require 'logger'
require 'yaml'

module Application
  # 定义配置类，可动态添加元素
  class Configuration
    # 动态添加属性
    def method_missing(name, *args, &block)
      attr_name = name.to_s
      index = attr_name.index('=')
      if index
        attr_name = attr_name[0, index]
      end

      code = %Q{
        def #{attr_name}=(value)
          @#{attr_name} = value
        end

        def #{attr_name}
          return @#{attr_name}
        end
      }

      self.class_eval code
      self.send(name, *args, &block)
    end
  end

  class << self
    attr_accessor :root
    attr_accessor :config
  end
  Application.root ||= File.expand_path('..', File.dirname(__FILE__))
  Application.config ||= Application::Configuration.new
end 


ActiveRecord::Base.logger = Logger.new("#{Application.root}/log/debug.log")
Application.config.dbconfig ||= YAML::load(IO.read("#{Application.root}/config/database.yml"))
ActiveRecord::Base.establish_connection(Application.config.dbconfig)

# migration path
Application.config.migration_path = "#{Application.root}/db/migrate"

# spider config
Application.config.qihu_spider_number=1
Application.config.min_sleep_time=5
Application.config.max_sleep_time=30

Dir.glob("#{Application.root}/lib/*.rb").each do |filename|
  require filename
end
