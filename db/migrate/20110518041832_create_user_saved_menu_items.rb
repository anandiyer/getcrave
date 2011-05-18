class CreateUserSavedMenuItems < ActiveRecord::Migration
  def self.up
    create_table :user_saved_menu_items do |t|
      t.integer :user_id
      t.integer :menu_item_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_saved_menu_items
  end
end
