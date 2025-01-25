# frozen_string_literal: true

require 'sinatra'
require './app'
require 'nokogiri'

get '/meals/index' do
  @meals = Meal.where(is_active: 1)
  erb :"meal/index"
end

get '/meals/create' do
  erb :"meal/create"
end

post '/meals/store' do
  user = User.find(session[:user_id])
  meal = user.meals.new(
    name: params[:name],
    calories: params[:calories]
  )

  if meal.save
    redirect '/meals/index'
  else
    @already_exist_meal = "Erreur : #{meal.errors.full_messages.join(", ")}"
    erb :'meal/create'
  end
end

get '/meals/delete/:meal_id' do
  user = User.find(session[:user_id])
  meal = user.meals.find_by(id: params[:meal_id])

  meal.update(is_active: 0, name:0)

  redirect '/meals/index'
end