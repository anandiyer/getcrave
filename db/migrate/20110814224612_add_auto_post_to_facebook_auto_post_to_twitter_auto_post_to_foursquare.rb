class AddAutoPostToFacebookAutoPostToTwitterAutoPostToFoursquare < ActiveRecord::Migration
  def self.up
    add_column :users, :auto_post_to_facebook, :boolean, :default => false
    add_column :users, :auto_post_to_twitter, :boolean, :default => false
    add_column :users, :auto_post_to_foursquare, :boolean, :default => false
  end

  def self.down
    remove_column :users, :auto_post_to_foursquare
    remove_column :users, :auto_post_to_twitter
    remove_column :users, :auto_post_to_facebook
  end
end
