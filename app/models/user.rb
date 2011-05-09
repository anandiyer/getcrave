class User < ActiveRecord::Base
  has_many :authorizations
  has_friendly_id :user_name, :use_slug => true
  attr_accessible :user_name
  
  def self.create_from_hash!(hash)
    create(:user_name => hash['user_info']['name'])
  end
end
