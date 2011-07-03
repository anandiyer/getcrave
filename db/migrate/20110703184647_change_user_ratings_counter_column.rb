class ChangeUserRatingsCounterColumn < ActiveRecord::Migration
  def self.up
    change_column :users, :user_ratings_count, :integer, :default => 0
    
    User.reset_column_information
    User.find(:all).each do |u|
      User.update_counters u.id, :user_ratings_count => u.menu_item_ratings.count
    end
  end

  def self.down
    change_column :users, :user_ratings_count, :integer
  end
end
