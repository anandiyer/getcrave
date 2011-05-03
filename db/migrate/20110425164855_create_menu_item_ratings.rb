class CreateMenuItemRatings < ActiveRecord::Migration
  def self.up
    create_table :menu_item_ratings do |t|
      t.integer :menu_item_id
      t.integer :user_id
      t.integer :rating
      t.string :review

      t.timestamps
    end
  end

  def self.down
    drop_table :menu_item_ratings
  end
end
