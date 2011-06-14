class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :is_almazom?


  def is_almazom?
    request.server_port == 3006
  end


  protected

  def current_user
#TODO: fix me
    begin
      @current_user ||= User.find_by_id(session[:user_id])
    rescue
#      logger.info(e+" | Can not find current_user")
      @current_user = User.find(5)
    end
#    @current_user ||= User.where(:user_name => "almazom").first
#    @current_user ||= User.where(:user_name => "ai").first
#    @current_user ||= User.where(:user_name => "test3").first
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
    session[:user_id] = user.id
  end
end
