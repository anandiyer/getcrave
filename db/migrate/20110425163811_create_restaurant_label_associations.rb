class CreateRestaurantLabelAssociations < ActiveRecord::Migration
  def self.up
    create_table :restaurant_label_associations do |t|
      t.integer :restaurant_id
      t.integer :restaurant_label_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :restaurant_label_associations
  end
end
