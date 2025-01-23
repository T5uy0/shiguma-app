# frozen_string_literal: true
# 
require 'sinatra'
require './app'
require 'nokogiri'

get '/' do
  @user = User.find(session[:user_id]);
  @daily_consumptions = @user.consumptions.where(consumed_at: Date.today.all_day)
  @daily_consumptions_empty = false

  if @daily_consumptions.empty?
    @daily_consumptions_empty = true
  end
  erb :"consumption/index"
end

get '/consumptions/edit' do
  erb :"consumption/edit"
end