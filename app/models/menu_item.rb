class MenuItem < ActiveRecord::Base
    belongs_to  :restaurant
    has_many    :menu_item_ratings
    has_many    :menu_item_photos
    has_many    :user_saved_menu_items
    has_one     :menu_item_avg_rating_count
    has_many    :menu_label_associations
    has_friendly_id :name, :use_slug => true, :approximate_ascii => true
    acts_as_mappable :through => :restaurant
    
    searchable do
          text :menu_restaurant_name, :default_boost => 8 do
           name + " " + restaurant.name
          end
          text :menu_labels, :default_boost => 6 do
            menulabels = ""
            self.labels.each { |l| menulabels << l + " "}
            name + " " + menulabels
          end
          text :name, :default_boost => 4
          text :description
          location :coordinates do
            Sunspot::Util::Coordinates.new(restaurant.latitude, restaurant.longitude)
          end
    end

# vars - menu_label_id, menu_item_id
  def labels_counter menu_label_id, menu_item_id
    MenuLabelAssociation.where(:menu_label_id => menu_label_id, :menu_item_id => menu_item_id).count
  end

  def labels
    MenuLabel.find(self.menu_label_associations.map{|l| l.menu_label_id}).map{|ln| ln.menu_label}
  end
end
