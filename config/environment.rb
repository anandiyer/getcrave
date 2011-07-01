# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Crave::Application.initialize!

puts Rails.env

ITEMS_PER_PAGE = 25

ActionMailer::Base.smtp_settings = {
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => ENV['SENDGRID_DOMAIN'],
  :address        => "smtp.sendgrid.net",
  :port           => "25",
  :authentication => :plain,
  :enable_starttls_auto => true
}

#  TODO: dublicate to production.rb

 AWS::S3::Base.establish_connection!(
    :access_key_id     => '1BMA7PKM3W1YE7FDW982',
    :secret_access_key => 'LhuJn+arXovIbBj3h/+PvnNHuck/Vsltk9/kvmm5'
  )

#  TODO: change 2 your bucket name
  BUCKET = "getcrave"
