class SessionsController < ApplicationController
  def create

    p "session#create -----------------------------------------------------"
    auth = request.env["omniauth.auth"]
    p token =  auth['credentials']['token']

    if !token
      render :status => 404 and return #for bots
    end

    p "!@auth---------------------------"
    p @auth

    unless @auth = Authorization.find_from_hash(auth)
      p "!!!!!!!!!!!!!!!!!!!!!!!!!!!not Authorization for this user "
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
        1412419249, #almazom
        100002478207683, #almazom_test
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


      p "********************54*********************88"

      p "-----if not autharization we will create one"
      @auth = Authorization.create_from_hash(auth, current_user)

      p "57"
      Notifier.signup_email(@auth.user).deliver
    end

    # Log the authorizing user in.
    p "Log the authorizing user in."
    p @auth




#    begin
      self.current_user = @auth.user
#    rescue NoMethodError
#      redirect_to root_path
#
#    end






    p "-------------------------------------------"
#    TODO: change to blank if will be work
    if @auth.token.blank?
      p a_find = Authorization.find_from_hash(auth)
      a_find.token = token
      a_find.save
      p a_find.valid?
      p a_find.errors

    end
    p "-------------------------------------------"

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
