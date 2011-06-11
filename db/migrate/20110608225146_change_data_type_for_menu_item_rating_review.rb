class ChangeDataTypeForMenuItemRatingReview < ActiveRecord::Migration
  def self.up
    change_table :menu_item_ratings do |t|
      t.change :review, :text
    end
  end

  def self.down
    change_table :menu_item_ratings do |t|
      t.change :review, :string
    end
  end
end
