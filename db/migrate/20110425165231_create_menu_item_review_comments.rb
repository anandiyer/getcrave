class CreateMenuItemReviewComments < ActiveRecord::Migration
  def self.up
    create_table :menu_item_review_comments do |t|
      t.integer :menu_item_rating_id
      t.integer :user_id
      t.string :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :menu_item_review_comments
  end
end
