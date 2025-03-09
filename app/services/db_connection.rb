# frozen_string_literal: true
require 'active_record'

# Class for the database connection
class DBConnection
  include Singleton

  def initialize
    @environment = ENV['RACK_ENV'] || 'development'
    connect_mariadb
  end

  def connect_mariadb
    db_config = YAML.load_file('config/database.yml')[@environment]
    ActiveRecord::Base.establish_connection(db_config)
    $logger.info('MariaDB successfully connected')
  rescue ActiveRecord::ActiveRecordError => e
    $logger.error("MariaDB connection error: #{e.message}")
  end
end