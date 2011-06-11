# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Crave::Application.initialize!

ActionMailer::Base.smtp_settings = { 
    :user_name => "app518646@heroku.com",
    :password => "5b29d416c8d90bec0a",
    :domain => "getcrave.com",
    :address => "smtp.sendgrid.net",
    :port => 25,
    :authentication => :plain,
    :enable_starttls_auto => true
}