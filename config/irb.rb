# frozen_string_literal: true

require 'bundler/setup'
require 'sinatra/activerecord'
require 'active_record'

db_config = YAML.load_file('config/database.yml')
ActiveRecord::Base.establish_connection(db_config['development'])

# Load all models
Dir['./app/models/*.rb'].sort.each { |file| require file }