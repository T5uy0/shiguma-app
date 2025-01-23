require 'sinatra/activerecord/rake'

require 'active_record'

db_config = YAML.load_file('config/database.yml')
ActiveRecord::Base.configurations = db_config
ActiveRecord::Base.establish_connection(db_config[ENV['RACK_ENV'] || 'development'])