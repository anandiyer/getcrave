# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Crave::Application.initialize!

puts Rails.env

ITEMS_PER_PAGE = 25

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
