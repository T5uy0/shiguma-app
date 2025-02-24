# frozen_string_literal: true

require 'sinatra'
require './app'
require 'nokogiri'

get '/masses/index' do
  @user = User.find(session[:user_id]);
  @masses_is_empty = false
  masses = @user.masses
  if masses.empty?
    @masses_is_empty = true
  end
  erb :"mass/index"
end

get '/masses/create' do
  erb :"mass/create"
end

post '/masses/store' do
  user = User.find(session[:user_id])
  mass = user.masses.new(
    mass: params[:mass]
  )

  if mass.save
    redirect '/masses/index', 302, { "location" => "/masses/index" }
  else
    @err = "Erreur : Vous ne pouvez pas pesé #{mass.mass} kg"
    erb :'mass/create'
  end
end

get '/masses/:mass_id/delete' do
  user = User.find(session[:user_id])
  mass = user.masses.find_by(id: params[:mass_id])

  if mass.nil?
    erb :"error/404"
  else
    mass.destroy()
    redirect '/masses/index', 302, { "location" => "/masses/index" }
  end
end

get '/masses/:mass_id/edit' do
  user = User.find(session[:user_id]);
  @mass = user.masses.find_by(id: params[:mass_id])
  erb :"mass/edit"
end

post '/masses/:mass_id/update' do
  user = User.find(session[:user_id])
  mass = user.masses.find_by(id: params[:mass_id])

  if mass.nil?
    erb :"error/404"
  else
    mass.update(mass: params['mass'])
    redirect '/masses/index', 302, { "location" => "/masses/index" }
  end
end