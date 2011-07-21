class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    token =  auth['credentials']['token']

    if !token
      render :status => 404 and return #for bots
    end

    unless @auth = Authorization.find_from_hash(auth)
      
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      
      if ((auth['provider'] == 'facebook') || (auth['provider'] == 'twitter'))
        @authuid = auth['uid'].to_i
        @conditions = " facebook_id = #{@authuid}"
        @tester = AlphaTester.find(:first, :conditions => @conditions)

        if (!@tester || !@tester.authorized)
          redirect_to '/request.html'
          return
        end
      elsif (auth['provider'] == 'foursquare')
        # Let's save this user's phone number if available
        current_user.telephone = auth['user_info']['phone'] 
        current_user.save
      end
      
      @auth = Authorization.create_from_hash(auth, current_user)
  
      # TODO: we shouldn't have to do this if the user is simply
      # assocating their account with another provider. Do this
      # only for first time account creators
      if ((auth['provider'] == 'facebook') && (@auth.user))
        Notifier.signup_email(@auth.user).deliver
      end
    end

    # Twitter & Facebook are the only supported auth mechanisms right now
    if ((auth['provider'] == 'facebook') || (auth['provider'] == 'twitter'))
      # Log the authorizing user in.
      begin
        self.current_user = @auth.user
      rescue NoMethodError
        redirect_to root_path
      end

      if @auth.token.blank?
        a_find = Authorization.find_from_hash(auth)
        a_find.token = token
        a_find.save
      end
    end

    # If coming from an iPhone, redirect to another page with the user_id
    # TODO: turning off autoredirects while in alpha
    p "debugging: "+session[:redirect_to]
    if (session[:redirect_to].include? 'mobile')
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
