class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :is_authorized?
  helper_method :current_user, :signed_in?, :check_auth_fb, :is_authorized?

  protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  
  def is_authorized?
    if (request.request_uri.include?'/auth/')
      is_auth_path = true
    else
      is_auth_path = false
    end

    if (request.domain.include?('heroku'))
      is_heroku = true
    else
      is_heroku = false
    end
      
    if ((request.request_uri.include?'/mobile/') || (params[:mobile]))
      is_mobile = true
    else
      is_mobile = false
    end

    if !signed_in? && !is_mobile && !is_auth_path && !is_heroku
      redirect_to("/index.html") and return
    end
  end

  def check_auth_fb
    title = "Please sign in!"
    if !signed_in? && !is_mobile?
      render :js => "window.show_dialog(\"#{title}\")"
    end
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id if user
  end
end
