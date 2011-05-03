class AddLatitudeLongitudeToRestaurant < ActiveRecord::Migration
  def self.up
    add_column :restaurants, :latitude_longitude, :point, :srid => -1
    add_index  :restaurants, :latitude_longitude, :spatial => true
  end

  def self.down
    remove_column :restaurants, :latitude_longitude
    remove_index  :restaurants, :latitude_longitude
  end
end
