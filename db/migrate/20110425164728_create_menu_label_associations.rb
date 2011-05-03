class CreateMenuLabelAssociations < ActiveRecord::Migration
  def self.up
    create_table :menu_label_associations do |t|
      t.integer :menu_item_id
      t.integer :menu_label_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :menu_label_associations
  end
end
