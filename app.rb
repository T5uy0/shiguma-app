# frozen_string_literal: true

SERVICE_FOLDER = './app/services' unless defined?(SERVICE_FOLDER)
CONTROLLERS_FOLDER = './app/controllers' unless defined?(CONTROLLERS_FOLDER)
MODELS_FOLDER = './app/models' unless defined?(MODELS_FOLDER)
VIEWS_FOLDER = './app/views' unless defined?(VIEWS_FOLDER)
MIDDLEWARES_FOLDER = './app/middlewares' unless defined?(MIDDLEWARES_FOLDER)
CONFIG_FOLDER = './config' unless defined?(CONFIG_FOLDER)

require 'sinatra'
require 'sinatra/activerecord'
require 'rubygems'
require 'chartkick'
require 'dotenv/load'
require "#{CONFIG_FOLDER}/logger"
require "#{SERVICE_FOLDER}/db_connection"
require 'i18n'

# Définir le port correctement pour Render
set :port, ENV.fetch('PORT', 4567)
set :bind, '0.0.0.0' # Permet d'écouter toutes les connexions

I18n.load_path << 'config/locales/fr.yml'
I18n.default_locale = :fr

set :environment, (ENV['RACK_ENV'] || 'development').to_sym
set :views, File.join(VIEWS_FOLDER)
set :logger, $logger

DBConnection.instance

Dir[File.join(CONTROLLERS_FOLDER, '*.rb')].sort.each { |file| require file }
Dir[File.join(MODELS_FOLDER, '*.rb')].sort.each { |file| require file }
Dir[File.join(MIDDLEWARES_FOLDER, '*.rb')].sort.each { |file| require file }

configure do
  enable :sessions
end

configure :production do
  set :show_exceptions, false
  set :logging, false  # Désactive les logs en production pour éviter d’exposer des données
end

use Auth