class MenuItemPhoto < ActiveRecord::Base
  belongs_to  :menu_item
  belongs_to  :user
  attr_accessible :photo, :user_id, :menu_item_id
end
