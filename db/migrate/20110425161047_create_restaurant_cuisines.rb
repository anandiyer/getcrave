class CreateRestaurantCuisines < ActiveRecord::Migration
  def self.up
    create_table :restaurant_cuisines do |t|
      t.string :restaurant_cuisine

      t.timestamps
    end
  end

  def self.down
    drop_table :restaurant_cuisines
  end
end
