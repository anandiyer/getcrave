class CreateMenuItemIngredients < ActiveRecord::Migration
  def self.up
    create_table :menu_item_ingredients do |t|
      t.integer :menu_item_id
      t.integer :ingredient_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :menu_item_ingredients
  end
end
