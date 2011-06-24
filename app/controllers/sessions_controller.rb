class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    unless @auth = Authorization.find_from_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.

      # TODO: Beta If this user is not in the APPROVED LIST, we can't let'em in
      ids = [
        743181527, #shreya
        500034335, #anand
        80900323, #rich
        80900324, #sara
        662773250, #artignor
        6200447, #cyrus
        6239115, #greg
        629551728,
        586229596,
        207611,
        303895,
        686839298,
        521340130,
        80900009,
        515064005,
        80901397,
        100001103782215,
        12429364,
        535354602,
        15001447,
        604290,
        3304156,
        633516742
      ]
      
      if (!ids.include?(auth['uid'].to_i))
        # TODO: redirect to sorry page
        redirect_to '/request.html'
        return
      end
      
      @auth = Authorization.create_from_hash(auth, current_user)
      Notifier.signup_email(@auth.user).deliver
    end
    # Log the authorizing user in.
    self.current_user = @auth.user

    # If coming from an iPhone, redirect to another page with the user_id
    # TODO: turning off autoredirects while in alpha
    if is_iphone_request? && session[:redirect_to] == "http://getcrave.com/mobile/"
      redirect_to "/mobile/uid/?uid=" + current_user.id.to_s
    else
      if (session[:redirect_to] && !session[:redirect_to].empty?)
        redirect_to session[:redirect_to]
      else
        redirect_to request.env['omniauth.origin'] || search_index_path
      end
    end
  end
  
  def destroy
    session[:user_id] = nil
    session[:redirect_to] = nil
    
    # render :text => "Signed out!"
    # TODO: we should be redirecting "back" but for beta, we're going to take them to index.html
    # redirect_to :back
    redirect_to '/', :notice => "Signed out!"
  end
  
  private 
    def is_iphone_request?
      request.user_agent =~ /(Mobile.+Safari)/
    end
end
