class AddUserProfilePicUrlToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :user_profile_pic_url, :string
  end

  def self.down
    remove_column :users, :user_profile_pic_url
  end
end
