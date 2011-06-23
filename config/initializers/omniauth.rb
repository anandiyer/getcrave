CONFIG = YAML.load_file("#{RAILS_ROOT}/config/facebook.yml")[RAILS_ENV]
APP_ID = CONFIG['app_id']
APP_SECRET = CONFIG['app_secret']

# OmniAuth.config.full_host = "http://localhost"

Rails.application.config.middleware.use OmniAuth::Builder do
  # This cert location is only for Heroku

  #  provider :facebook, APP_ID, APP_SECRET, {:client_options => {:ssl => {:ca_file => "/etc/ssl/certs"}}}
  #end

  provider :facebook,
    APP_ID,
    APP_SECRET,{ :display => 'page',:scope => 'publish_stream, offline_access, email, user_photos', :client_options => {:ssl => {:ca_file => "/usr/lib/ssl/certs/ca-certificates.crt"}}}
end

