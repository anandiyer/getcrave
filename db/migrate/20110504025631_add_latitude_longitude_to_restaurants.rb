class AddLatitudeLongitudeToRestaurants < ActiveRecord::Migration
  def self.up
    # add_column :restaurants, :latitude, :float
    # add_column :restaurants, :longitude, :float
  end

  def self.down
    # remove_column :restaurants, :longitude
    # remove_column :restaurants, :latitude
  end
end
