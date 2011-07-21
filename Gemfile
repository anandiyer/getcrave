source 'http://rubygems.org'

gem 'rails', '3.0.7'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'
gem 'spatial_adapter' # To handle PostGIS datatypes
gem 'geokit'
gem 'friendly_id', "~> 3.2.1"
gem 'sunspot_rails', "~> 1.2.1"
gem 'jquery-rails', '>= 0.2.6'
gem "haml"
gem "haml-rails"
gem 'json'
gem "gritter"
gem "acts_as_opengraph"
gem "uuidtools"
gem 'aws-s3', '0.6.2', :require => 'aws/s3'
gem 'will_paginate', "~> 3.0.pre2"
gem 'kaminari'
gem 'omniauth'

gem "fb_graph" #for fb share

group :development, :test do
  gem 'thin'
  gem 'cucumber-rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'webrat'
  gem "erb2haml"
  gem "compass", :require => false
  gem 'jquery-rails', '>= 0.2.6'
  gem "haml"
  gem "haml-rails"
  gem "faraday"
  gem 'ruby-debug' 
end

group :production do
  gem 'rack-google_analytics', :require => "rack/google_analytics"
end

# http://postgis.refractions.net/download/
# http://postgis.refractions.net/docs/ch02.html
# must install postgis and import postgis.sql(or postgis-64.sql) file
# without postgis.sql import you can not rake db:migrate
