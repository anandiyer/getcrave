class MenuItemRating < ActiveRecord::Base
    belongs_to  :menu_item, :counter_cache => true
    belongs_to  :user, :counter_cache => true
    belongs_to  :restaurant
    has_many    :menu_item_rating_helpfuls
end
