class Auth
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    session = env['rack.session']

    if session[:user_id].nil? && !['/login', '/register'].include?(request.path)
      return [302, { 'Location' => '/login' }, []]
    elsif !session[:user_id].nil? && ['/login', '/register'].include?(request.path)
      [302, { 'Location' => '/' }, []]
    end

    @app.call(env)
  end
end