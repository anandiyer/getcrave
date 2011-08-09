class AddFoursquareToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :get_foursquare_recommendations, :boolean, :default => false
  end

  def self.down
    remove_column :users, :get_foursquare_recommendations, :boolean
  end
end
