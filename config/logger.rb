# frozen_string_literal: true

require 'logger'
require 'date'

Dir.mkdir('logs') unless Dir.exist?('logs')

# Define log file path with current date
LOG_PATH = "logs/#{Date.today.strftime('%Y-%m-%d')}.log"

# Configure the logger
$logger = Logger.new(LOG_PATH, 'daily')
$logger.level = Logger::DEBUG