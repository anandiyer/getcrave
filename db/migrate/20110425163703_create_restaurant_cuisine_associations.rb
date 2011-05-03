class CreateRestaurantCuisineAssociations < ActiveRecord::Migration
  def self.up
    create_table :restaurant_cuisine_associations do |t|
      t.integer :restaurant_id
      t.integer :restaurant_cuisine_id

      t.timestamps
    end
  end

  def self.down
    drop_table :restaurant_cuisine_associations
  end
end
