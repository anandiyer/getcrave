class SessionsController < ApplicationController
  def create
    session[:return_to] = request.referer

    auth = request.env["omniauth.auth"]
    unless @auth = Authorization.find_from_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    # Log the authorizing user in.
    self.current_user = @auth.user

    # FIXME - redirect to the calling URL
    # render :text => "Welcome, #{current_user.user_name}."
    
    # If coming from an iPhone, redirect to another page with the user_id
    if is_iphone_request?
      redirect_to "/mobile/uid?uid=" + current_user.id.to_s
    else
     redirect_to session[:return_to]
    end
  end

  def destroy
    session[:user_id] = nil
    
    # render :text => "Signed out!"
    # redirect_to root_url, :notice => "Signed out!"
    redirect_to :back
  end
  
  private 
    def is_iphone_request?
      request.user_agent =~ /(Mobile\/.+Safari)/
    end
end
