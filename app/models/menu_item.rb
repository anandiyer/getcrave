class MenuItem < ActiveRecord::Base
    belongs_to  :restaurant
    has_many    :menu_item_ratings
    has_many    :menu_item_photos
    has_many    :user_saved_menu_items
    has_one     :menu_item_avg_rating_count
    has_many    :menu_label_associations
    acts_as_mappable :through => :restaurant
    
    searchable do
        text :name, :default_boost => 2
        text :description
        location :coordinates do
          Sunspot::Util::Coordinates.new(restaurant.latitude, restaurant.longitude)
        end
    end


  def labels
    %W{Gluten_free Gluten_free}
  end
end
