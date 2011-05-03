class CreateRestaurantLabels < ActiveRecord::Migration
  def self.up
    create_table :restaurant_labels do |t|
      t.string :restaurant_label

      t.timestamps
    end
  end

  def self.down
    drop_table :restaurant_labels
  end
end
