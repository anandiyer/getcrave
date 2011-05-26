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

#kill me
gem "uuidtools"

gem 'aws-s3', '0.6.2', :require => 'aws/s3'


group :development, :test do
  gem 'cucumber-rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'webrat'
  gem 'mongrel'
  gem "erb2haml"
  gem "compass", :require => false
<<<<<<< HEAD
  gem 'jquery-rails', '>= 0.2.6'
  gem "haml"
  gem "haml-rails"
  gem "faraday"

=======
#  gem "compass-susy-plugin"
>>>>>>> 5d829f4d1e03592a3bf9745f94b8ca990f44e385
end

group :production do
  gem 'rack-google_analytics', :require => "rack/google_analytics"
end

# http://postgis.refractions.net/download/
# http://postgis.refractions.net/docs/ch02.html
# must install postgis and import postgis.sql(or postgis-64.sql) file
# without postgis.sql import you can not rake db:migrate
