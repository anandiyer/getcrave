class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

    def current_user
#      TODO : mock for almazom please uncomment me in production
      @current_user ||= User.find_by_id(session[:user_id])
#      @current_user ||= User.where(:user_name => "almazom").first
#      @current_user ||= User.first()
    end

      def signed_in?
        !!current_user
      end

    helper_method :current_user, :signed_in?

    def current_user=(user)
      @current_user = user
      session[:user_id] = user.id
    end
end
