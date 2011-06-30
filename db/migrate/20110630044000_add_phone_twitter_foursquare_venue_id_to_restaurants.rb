class AddPhoneTwitterFoursquareVenueIdToRestaurants < ActiveRecord::Migration
  def self.up
    add_column :restaurants, :twitter, :string
    add_column :restaurants, :telephone, :bigint
    add_column :restaurants, :foursquare_venue_id, :string
  end

  def self.down
    remove_column :restaurants, :twitter
    remove_column :restaurants, :telephone
    remove_column :restaurants, :foursquare_venue_id
  end
end
