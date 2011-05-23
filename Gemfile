source 'http://rubygems.org'

gem 'rails', '3.0.7'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'
gem 'spatial_adapter' # To handle PostGIS datatypes
gem 'geokit'
gem 'friendly_id', "~> 3.2.1"
gem 'sunspot_rails', "~> 1.2.1"
gem 'omniauth'
gem 'jquery-rails', '>= 0.2.6'
gem "haml"
gem "haml-rails"
gem 'json'
gem "gritter"

group :development, :test do
  gem 'cucumber-rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'webrat'
  gem 'mongrel'
  gem "erb2haml"
  gem "compass", :require => false
#  gem "compass-susy-plugin"

end


# http://postgis.refractions.net/download/
# http://postgis.refractions.net/docs/ch02.html
# must install postgis and import postgis.sql(or postgis-64.sql) file
# without postgis.sql import you can not rake db:migrate
