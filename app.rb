# frozen_string_literal: true

SERVICE_FOLDER = './app/services' unless defined?(SERVICE_FOLDER)

require "#{SERVICE_FOLDER}/db_connection"

set :environment, ENV.fetch('RACK_ENV') || 'development'

DBConnection.instance