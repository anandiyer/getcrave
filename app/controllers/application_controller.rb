class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :is_almazom?


  def is_almazom?
    request.server_port == 3006
  end


  protected

  def current_user
#TODO: fix me
    if is_almazom?
      @current_user ||= User.where(:user_name => "almazom_new_user").first
    else
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end

  def check_auth_fb

    title = "Please sign in!"
    if !signed_in?
      render :js => "window.show_dialog(\"#{title}\")"
    end
  end



  def signed_in?
#    true
#    TODO: UNTIL FACEBOOCK NOT WORK
    !!current_user
  end

  helper_method :current_user, :signed_in?, :check_auth_fb

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id if user
  end
end
