class User < ActiveRecord::Base
  has_many :authorizations
  has_many :menu_item_ratings
  has_many :user_saved_menu_items
  has_many :user_followings
  has_friendly_id :user_name, :use_slug => true
  attr_accessible :user_name, :user_profile_pic_url
  
  def self.create_from_hash!(hash)
    create(:user_name => hash['user_info']['name'])
  end


  def is_following? following_user_id
    User.find(following_user_id).user_followings.where(:following_user_id => self.id).any?
  end

  def small_thumbnail
    self.user_profile_pic_url ? self.user_profile_pic_url : "reviews_avatar_temp.png"
  end
end
