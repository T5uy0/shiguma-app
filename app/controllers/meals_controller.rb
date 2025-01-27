# frozen_string_literal: true

require 'sinatra'
require './app'
require 'nokogiri'

get '/meals/index' do

  @meals = Meal.where(is_active: true)
              .where(user_id: session[:user_id])
              .or(Meal.where(is_active: true).where(is_default: true))

  @meals_is_empty = false
  if @meals.empty?
    @meals_is_empty = true
  end

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

  meal.update(is_active: 0)
  redirect '/meals/index'
end