class CreateMenuItemPrices < ActiveRecord::Migration
  def self.up
    create_table :menu_item_prices do |t|
      t.integer :menu_item_id
      t.string :price_for
      t.decimal :price
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :menu_item_prices
  end
end
