class CreateMenuItemPhotos < ActiveRecord::Migration
  def self.up
    create_table :menu_item_photos do |t|
      t.integer :menu_item_id
      t.string :photo
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :menu_item_photos
  end
end
