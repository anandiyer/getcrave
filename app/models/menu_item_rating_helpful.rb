class MenuItemRatingHelpful < ActiveRecord::Base
  belongs_to  :menu_item_rating
  validates_uniqueness_of :menu_item_rating_id, :scope => :user_id
  validates_presence_of :menu_item_rating_id, :user_id
end