class StoreRedirectTo
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    path = request.path
    signin  = path.match(%r(^/auth/[^/]+$)) && path != '/auth/failure'
    signout = path == '/users/signout'
    if signin || signout
      redirect = request.params['redirect_to'] || request.referer
      request.session['redirect_to'] = redirect if redirect
      request.session['user_id'] = request.params['user_id'] if request.params['user_id']
      p "DEBUGGING 2"
      p signin
      p request.session['user_id']
    end

    @app.call(env)
  end
end