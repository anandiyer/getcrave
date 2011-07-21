FB_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/facebook.yml")[RAILS_ENV]
FS_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/foursquare.yml")[RAILS_ENV]
TWITTER_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/twitter.yml")[RAILS_ENV]
FB_APP_ID = FB_CONFIG['app_id']
FB_APP_SECRET = FB_CONFIG['app_secret']
FS_APP_ID = FS_CONFIG['app_id']
FS_APP_SECRET = FS_CONFIG['app_secret']
TWITTER_APP_ID = TWITTER_CONFIG['app_id']
TWITTER_APP_SECRET = TWITTER_CONFIG['app_secret']

# OmniAuth.config.full_host = "http://localhost"

Rails.application.config.middleware.use OmniAuth::Builder do
  # This cert location is only for Heroku

  provider :facebook, FB_APP_ID, FB_APP_SECRET,
    { :display => 'page', 
      :scope => 'publish_stream,email,offline_access',
      :client_options => {:ssl => {:ca_file => "/usr/lib/ssl/certs/ca-certificates.crt"}}}
      
  provider :foursquare, FS_APP_ID, FS_APP_SECRET,
    { :display => 'page', :client_options => {:ssl => {:ca_file => "/usr/lib/ssl/certs/ca-certificates.crt"}}}

  provider :twitter, TWITTER_APP_ID, TWITTER_APP_SECRET

  #solution for almazoms ssl problems
  #provider :facebook, APP_ID, APP_SECRET, {:client_options => {:ssl => {:ca_file => "/etc/ssl/certs"}}}
  #OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
end