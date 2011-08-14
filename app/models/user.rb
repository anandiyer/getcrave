class User < ActiveRecord::Base
  has_many :authorizations
  has_many :menu_item_ratings
  has_many :user_saved_menu_items
  has_many :user_followings
  has_many :menu_item_photos
  has_many :menu_label_associations
  has_many :foursquare_checkins
  has_friendly_id :user_name, :use_slug => true
  attr_accessible :user_name, :user_profile_pic_url, :email, :telephone, :bio, :get_foursquare_recommendations, :auto_post_to_facebook, :auto_post_to_twitter, :auto_post_to_foursquare
  attr_accessor :this_user
  validates_uniqueness_of :user_name
  
  def self.create_from_hash_facebook!(hash)
    @url = "http://graph.facebook.com/" + hash['uid'] + "/picture"
    
    create(:user_name => hash['user_info']['name'], 
      :user_profile_pic_url => @url,
      :email => hash['user_info']['email'])
  end

  def self.create_from_hash_twitter!(hash)
    p hash
    create(:user_name => hash['user_info']['nickname'], 
      :user_profile_pic_url => hash['user_info']['image'],
      :bio => hash['user_info']['description'])
  end

  def followed_by_current_user
    if this_user
      this_user.user_followings.where(:following_user_id => self.id).any?
    else
      return false
    end
  end

  def following_current_user
    if this_user
      self.user_followings.where(:following_user_id => this_user.id).any?
    else
      return false
    end
  end

  def count_ratings_this_week
    # Using UTC as everything in the dB is stored in UTC
    @now = Time.now.utc
    @beginning_of_week = @now.beginning_of_week.utc

    @user_id = self.id

    @conditions = " user_id = #{@user_id} AND created_at > \'#{@beginning_of_week}\' AND created_at <= \'#{@now}\'"
    
    @menu_item_ratings = MenuItemRating.find(:all, :conditions => @conditions) 
    
    return (@menu_item_ratings.count)
  end

  def is_following? following_user_id
    self.user_followings.where(:following_user_id => following_user_id).any?
  end

  def small_thumbnail
    (self.user_profile_pic_url && !self.user_profile_pic_url.empty?) ? self.user_profile_pic_url : "reviews_avatar_temp.png"
  end

  def following
    UserFollowing.where(:user_id => self.id).all
  end

  def followers
    UserFollowing.where(:following_user_id => self.id).all
  end

  def following_count
    UserFollowing.where(:user_id => self.id).all.count
  end

  def followers_count
    UserFollowing.where(:following_user_id => self.id).all.count
  end
  
  def saved_count
    self.user_saved_menu_items.count
  end
  
  def reviews
    self.menu_item_ratings
  end

  def saved
    self.user_saved_menu_items
  end
end
