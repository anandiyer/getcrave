class ApplicationController < ActionController::Base
  protect_from_forgery



  protected

  def current_user
#    @current_user ||= User.find_by_id(session[:user_id])
    @current_user ||= User.where(:user_name => "almazom").first
#    @current_user ||= User.where(:user_name => "ai").first
  end

  def check_auth_fb

    title = "Please sign in!"
    if !signed_in?
#      p "not signed"
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
    session[:user_id] = user.id
  end
end
