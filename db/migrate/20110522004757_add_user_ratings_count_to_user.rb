class AddUserRatingsCountToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :user_ratings_count, :integer
    
    User.reset_column_information
    User.find(:all).each do |u|
      User.update_counters u.id, :user_ratings_count => u.menu_item_ratings.count
    end
  end

  def self.down
    remove_column :users, :user_ratings_count
  end
end
