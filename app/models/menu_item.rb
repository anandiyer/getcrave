class MenuItem < ActiveRecord::Base
    belongs_to  :restaurant
    has_many    :menu_item_ratings
    
    searchable do
        text :name, :default_boost => 2
        text :description
    end
end
