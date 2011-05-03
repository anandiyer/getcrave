class CreateRestaurants < ActiveRecord::Migration
  def self.up
    create_table :restaurants do |t|
      t.string :name
      t.string :street_address
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :cross_street

      t.timestamps
    end
  end

  def self.down
    drop_table :restaurants
  end
end
