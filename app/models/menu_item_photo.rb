class MenuItemPhoto < ActiveRecord::Base
  belongs_to  :menu_item
  attr_accessible :photo
end
