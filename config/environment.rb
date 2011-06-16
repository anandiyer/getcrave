# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Crave::Application.initialize!

puts Rails.env

ITEMS_PER_PAGE = 25

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :user_name => "app518646@heroku.com",
    :password => "5b29d416c8d90bec0a",
    :domain => "getcrave.com",
    :address => "smtp.sendgrid.net",
    :port => 25,
    :authentication => :plain,
    :enable_starttls_auto => true
}
config.action_mailer.raise_delivery_errors = true

#  TODO: change 2 your key and dublicate to production.rb
#  TODO: its my amazon keys

 AWS::S3::Base.establish_connection!(
    :access_key_id     => '1BMA7PKM3W1YE7FDW982',
#    :access_key_id     => 'AKIAIZHVKH4OQCX62L5Q',
    :secret_access_key => 'LhuJn+arXovIbBj3h/+PvnNHuck/Vsltk9/kvmm5'
#    :secret_access_key => '9zoZ3g+OWQxfiqS3ojGT4NuAMwvL0rHKdFoxKiS4'
  )

#  TODO: change 2 your bucket name
  BUCKET = "getcrave"
