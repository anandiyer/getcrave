class MenuItemRating < ActiveRecord::Base
    belongs_to  :menu_item
    belongs_to  :user
    belongs_to  :restaurant, :through => :menu_item
end
