# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Crave::Application.initialize!

ITEMS_PER_PAGE = 25
ITEMS_SIDEBAR = 10

ActionMailer::Base.smtp_settings = {
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => ENV['SENDGRID_DOMAIN'],
  :address        => "smtp.sendgrid.net",
  :port           => "25",
  :authentication => :plain,
  :enable_starttls_auto => true
}

AWS::S3::Base.establish_connection!(
    :access_key_id     => '1BMA7PKM3W1YE7FDW982',
    :secret_access_key => 'LhuJn+arXovIbBj3h/+PvnNHuck/Vsltk9/kvmm5'
)

BUCKET = "getcrave"

# your Twilio authentication credentials
ACCOUNT_SID = "AC63aa7b49d6276f5af9470212f0d79cc7"
ACCOUNT_TOKEN = "e43ca3c756f1e749b9e61bddca7f741f"

# version of the Twilio REST API to use - do not change
API_VERSION = '2010-04-01'

# Sandbox phone number
# or outgoing Caller ID you have purchased through Twilio
# CALLER_ID = "+14155992671"
CALLER_ID = "+14153478834"

#CALLER_PIN only needed to send using sandbox number. Looks like 9999-9999
CALLER_PIN = "8298-5096"