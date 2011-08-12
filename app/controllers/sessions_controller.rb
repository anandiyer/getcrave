class SessionsController < ApplicationController
  def create
    @omniauth = request.env["omniauth.auth"]
    token =  @omniauth['credentials']['token']
    secret = @omniauth['credentials']['secret']

    if !token
      render :status => 404 and return #for bots
    end

    unless @auth = Authorization.find_from_hash(@omniauth)
      
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      
      if ((@omniauth['provider'] == 'facebook') || (@omniauth['provider'] == 'twitter'))
        @authuid = @omniauth['uid'].to_i
        @conditions = " facebook_id = #{@authuid}"
        @tester = AlphaTester.find(:first, :conditions => @conditions)

        if (!@tester || !@tester.authorized)
          redirect_to '/request.html'
          return
        end
      elsif (@omniauth['provider'] == 'foursquare')
        
        p "DEBUGGING"
        p self.current_user
        p current_user
        
        # This is for the mobile use case - we have to get the uid first
        # before we associate the 4s auth with that user acccount
        if (!current_user)
          current_user = User.find_by_id(session[:user_id].to_i)
          p "HERE"
          p current_user
        end
        
        # Let's save this user's phone number if available

        current_user.telephone = @omniauth['user_info']['phone'] 
        current_user.get_foursquare_recommendations = true
        current_user.save
      end
      
      @auth = Authorization.create_from_hash(@omniauth, current_user)
  
      # TODO: we shouldn't have to do this if the user is simply
      # assocating their account with another provider. Do this
      # only for first time account creators
      if ((@omniauth['provider'] == 'facebook') && (@auth.user))
        Notifier.signup_email(@auth.user).deliver
      end
    end

    # Twitter & Facebook are the only supported auth mechanisms right now
    if ((@omniauth['provider'] == 'facebook') || (@omniauth['provider'] == 'twitter'))
      # Log the authorizing user in.
      begin
        self.current_user = @auth.user
        current_user = @auth.user
      rescue NoMethodError
        redirect_to root_path
      end

      if (@auth.token.blank? || @auth.secret.blank?)
        a_find = Authorization.find_from_hash(@omniauth)
        a_find.token = token
        a_find.secret = secret
        a_find.save
      end    
    end
    
    #Save last_logged_in time
    self.current_user.last_logged_in = Time.now
    self.current_user.save

    # If coming from an iPhone, redirect to another page with the user_id
    # TODO: turning off autoredirects while in alpha

    if ((session[:redirect_to]) && (session[:redirect_to].include? 'mobile'))
      redirect_to "/mobile/uid/?uid=" + self.current_user.id.to_s
    else
      if (session[:redirect_to] && !session[:redirect_to].empty?)
        redirect_to session[:redirect_to]
      else
        redirect_to activity_path
      end
    end
  end
  
  def destroy
    session[:user_id] = nil
    session[:redirect_to] = nil
    reset_session
    
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
