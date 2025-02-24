# frozen_string_literal: true

require 'bcrypt'
require 'valid_email'

get '/login' do
  erb :"login/index"
end

post '/login' do
  if check_login(params[:email], params[:password], session)
    redirect '/', 302, { "location" => "/" }
  else
    redirect '/login', 302, { "location" => "/login" }
  end
end

get '/register' do
  erb :"register/index"
end

post '/register' do
  if register_user(params[:name], params[:email], params[:password], session)
    redirect '/login', 302, { "location" => "/login" }
  else
    redirect '/register', 302, { "location" => "/register" }
  end
end

get '/user/edit' do
  @user = User.find(session[:user_id])
  erb :"login/edit"
end

post '/user/update' do
  @user = User.find(session[:user_id])

  if params['new_mdp'] === params['conf_new_mdp']
    @user.update(password_digest: BCrypt::Password.create(params['new_mdp']))
    @user.save
    redirect '/', 302, { "location" => "/" }
  else
    @err = "Votre confirmation de mot de passe n'est pas identique a votre nouveau mot de passe."
  end

end

get '/logout' do
  session.clear
  redirect '/login', 302, { "location" => "/login" }
end

##############################

def check_login(email, password, session)
  @user = User.find_by_email(email)
  error = false

  error = true if @user.nil? || !ValidateEmail.valid?(email)

  if !error && BCrypt::Password.new(@user.password_digest) == password
    session[:user_id] = @user.id
    return true
  end

  session[:error] = 'Email et/ou mot de passe incorrect.' if error
  false
end

def register_user(name, email, password, session)
  unless ValidateEmail.valid?(email)
    session[:error] = 'Email et/ou mot de passe (min 8 cara.) est incorrect.'
    return false
  end

  current_date = Time.now.strftime('%Y-%m-%d %H:%M')

  true if User.create(
    name: name,
    email: email,
    password_digest: BCrypt::Password.create(password),
    created_at: current_date,
    updated_at: current_date
  )
end