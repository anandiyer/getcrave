class CreateMenuItemRatingHelpfuls < ActiveRecord::Migration
  def self.up
    create_table :menu_item_rating_helpfuls do |t|
      t.integer :menu_item_rating_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :menu_item_rating_helpfuls
  end
end
