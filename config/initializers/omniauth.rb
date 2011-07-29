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

module OmniAuth
  module Strategies
    class Foursquare < OAuth2

#      MOBILE_USER_AGENTS =  'webos|ipod|iphone|mobile'

      def request_phase
        options[:display] = mobile_request? ? 'touch' : 'page'
        super
      end

      def mobile_request?
#        ua = Rack::Request.new(@env).user_agent.to_s
#        ua.downcase =~ Regexp.new(MOBILE_USER_AGENTS)

        Rack::Request.new(@env)
        @uri = @env['REQUEST_URI']

        if (@uri.include?'mobile')
          return true
        else
          return false
        end
      end

    end
  end
end

module OmniAuth
  module Strategies
    class Facebook < OAuth2

#      MOBILE_USER_AGENTS =  'webos|ipod|iphone|mobile'

      def request_phase
        options[:display] = mobile_request? ? 'touch' : 'page'
        super
      end

      def mobile_request?
#        ua = Rack::Request.new(@env).user_agent.to_s
#        ua.downcase =~ Regexp.new(MOBILE_USER_AGENTS)

        Rack::Request.new(@env)
        @uri = @env['REQUEST_URI']

        if (@uri.include?'mobile')
          return true
        else
          return false
        end
      end

    end
  end
end