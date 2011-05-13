class MenuItem < ActiveRecord::Base
    belongs_to  :restaurant
    has_many    :menu_item_ratings
    has_many    :menu_item_phtos
    has_one     :menu_item_avg_rating_count
    
    searchable do
        text :name, :default_boost => 2
        text :description
    end
end
