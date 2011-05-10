CONFIG = YAML.load_file("#{RAILS_ROOT}/config/facebook.yml")[RAILS_ENV]
APP_ID = CONFIG['app_id']
APP_SECRET = CONFIG['app_secret']

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, APP_ID, APP_SECRET
end