class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :s3_init

  protected

  def current_user
#    @current_user ||= User.find_by_id(session[:user_id])
    @current_user ||= User.where(:user_name => "almazom").first
  end

  def s3_init
    p "----------------------------------------------"

    AWS::S3::Base.establish_connection!(
      :access_key_id     => 'AKIAIZHVKH4OQCX62L5Q',
      :secret_access_key => '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'
    )
  end

  def signed_in?
    true
#    TODO: UNTIL FACEBOOCK NOT WORK
#    !!current_user
  end

  helper_method :current_user, :signed_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end
end
