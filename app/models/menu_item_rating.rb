class MenuItemRating < ActiveRecord::Base
    belongs_to  :menu_item
    belongs_to  :user
    belongs_to  :restaurant
    has_many    :menu_item_rating_helpfuls
end
