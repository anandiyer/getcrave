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


  def is_following? following_user_id
    self.user_followings.where(:following_user_id => following_user_id).any?
  end

  def small_thumbnail
    self.user_profile_pic_url ? self.user_profile_pic_url : "reviews_avatar_temp.png"
  end

  def following
    UserFollowing.where(:user_id => self.id).all
  end

  def followers
    UserFollowing.where(:following_user_id => self.id).all
  end

  def reviews
    self.menu_item_ratings
  end

  def saved
    self.user_saved_menu_items
  end
end
