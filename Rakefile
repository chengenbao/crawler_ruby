require './config/application'

namespace :db do
  desc "create databae"
  task :create do
    ActiveRecord::Base.establish_connection Application.config.dbconfig.merge('database' => 'mysql')
    ActiveRecord::Base.connection.create_database Application.config.dbconfig['database']
  end

  task :migrate do
    ActiveRecord::Base.establish_connection Application.config.dbconfig
    ActiveRecord::Migrator.migrate(Application.config.migration_path, ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
  end

  task :drop do
    ActiveRecord::Base.establish_connection Application.config.dbconfig.merge('database' => 'mysql')
    ActiveRecord::Base.connection.drop_database Application.config.dbconfig['database']
  end
end
