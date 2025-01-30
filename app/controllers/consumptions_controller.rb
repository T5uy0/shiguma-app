# frozen_string_literal: true

require 'sinatra'
require './app'
require 'nokogiri'

get '/' do
  @user = User.find(session[:user_id]);
  @daily_consumptions = @user.consumptions.where(consumed_at: Date.today.all_day)
  @daily_consumptions_empty = false
  
  @history = @user.consumptions.order(consumed_at: :desc).group_by { |c| I18n.l(c.consumed_at.to_date, format: "%d %B %Y") }

  if @history.empty?
    @history_consumptions_empty = true
  else
    @history_consumptions_empty = false
  end

  if @daily_consumptions.empty?
    @daily_consumptions_empty = true
  else
    @daily_calories = @daily_consumptions.sum { |consumption| consumption.meal.calories * consumption.quantity }
  end

  erb :"consumption/index"
end

get '/consumptions/create' do
  @meals = Meal.where(is_active:1)
  erb :"consumption/create"
end

post '/consumptions/store' do
  user = User.find(session[:user_id])
  meal = Meal.find(params[:meal])

  consumptions = user.consumptions.create(meal: meal, quantity: params[:quantity], consumed_at: Time.now)

  if consumptions.save
    redirect '/'
  else
    @err = "Erreur : #{meal.errors.full_messages.join(", ")}"
    erb :'meal/create'
  end
end