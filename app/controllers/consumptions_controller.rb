# frozen_string_literal: true

require 'sinatra'
require './app'
require 'nokogiri'
require 'chartkick'

get '/' do
  @user = User.find(session[:user_id]);
  @daily_consumptions = @user.consumptions.where(consumed_at: Date.today.all_day)
  @daily_consumptions_empty = false
  
  @history = @user.consumptions.order(consumed_at: :desc).group_by { |c| I18n.l(c.consumed_at.to_date, format: "%d %B %Y") }

  # Regrouper les consommations par jour et sommer les calories
  @calories_per_day = @user.consumptions
  .order(consumed_at: :asc)
  .group_by { |c| I18n.l(c.consumed_at.to_date, format: "%d %B %Y")}
  .transform_values do |consumptions|
    {
      total_calories: consumptions.sum { |c| c.meal.calories * c.quantity },
      details: consumptions
    }
  end

  @weight_data = @user.masses
  .order(:created_at)
  .map { |c| [I18n.l(c.created_at.to_date, format: "%d %B %Y"), c.mass] }


  if @calories_per_day.empty?
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

get '/consumptions/:consumption_id/delete' do
 
  user = User.find(session[:user_id])
  consumption = user.consumptions.find_by(id: params[:consumption_id])

  if consumption.nil?
    erb :"error/404"
  else
    consumption.delete()
    redirect '/'
  end
end

get '/consumptions/:consumption_id/edit' do
  user = User.find(session[:user_id])
  @consumption = user.consumptions.find_by(id: params[:consumption_id])

  if @consumption.nil?
    erb :"error/404"
  else
    @meals = Meal.where(is_active:1)
    erb :"consumption/edit"
  end
end

post '/consumptions/:consumption_id/update' do
  user = User.find(session[:user_id])
  consumption = user.consumptions.find_by(id: params[:consumption_id])

  consumption.update(meal_id: params['meal'],quantity: params['quantity'])

  if consumption.save
    redirect '/'
  else
    @err = "Erreur : #{consumption.errors.full_messages.join(", ")}"
    erb :'consumption/edit'
  end
end