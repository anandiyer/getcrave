class User < ActiveRecord::Base
  has_many :authorizations
  has_many :menu_item_ratings
  has_many :user_saved_menu_items
  has_many :user_followings
  has_friendly_id :user_name, :use_slug => true
  attr_accessible :user_name, :user_profile_pic_url, :email
  
  def self.create_from_hash!(hash)
    @url = "http://graph.facebook.com/" + hash['uid'] + "/picture"
    create(:user_name => hash['user_info']['name'], 
      :user_profile_pic_url => @url,
      :email => hash['user_info']['email'])
  end
end
