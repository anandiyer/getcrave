class MenuItem < ActiveRecord::Base
    belongs_to  :restaurant
    has_many    :menu_item_ratings
    has_many    :menu_item_photos
    has_many    :user_saved_menu_items
    has_one     :menu_item_avg_rating_count
    has_many    :menu_label_associations
    has_friendly_id :name, :use_slug => true, :approximate_ascii => true
    acts_as_mappable :through => :restaurant
    acts_as_opengraph :values => { :site_name => "crave", :type => "food" },
      :columns => {
        :title => :restaurant_and_menu_item_name,
        :image => :image,
        :latitude => :latitude, 
        :longitude => :longitude,
        :street_address => :street_address,
        :locality => :locality,
        :postal_code => :postal_code,
        :country_name => :country_name
      }
    
#    searchable do
#      text :name, :default_boost => 8
#      text :description, :default_boost => 6
#      text :menu_restaurant_name, :default_boost => 4 do
#        name + " " + restaurant.name
#      end
#      text :menu_labels, :default_boost => 2 do
#        menulabels = ""
#        self.labels.each { |l| menulabels << l + " "}
#        name + " " + menulabels
#      end
#
#      float :avg_rating
#      float :num_ratings
#      location :coordinates do
#        Sunspot::Util::Coordinates.new(restaurant.latitude, restaurant.longitude)
#      end
#    end

# vars - menu_label_id, menu_item_id
  def labels_counter menu_label_id, menu_item_id
    MenuLabelAssociation.where(:menu_label_id => menu_label_id, :menu_item_id => menu_item_id).count
  end

  def labels
    MenuLabel.find(self.menu_label_associations.map{|l| l.menu_label_id}).map{|ln| ln.menu_label}
  end

  def thumbnail
    if self.menu_item_photos.any?
      self.menu_item_photos.first.photo
    else
      "item_rest_temp_image.png"
    end
  end
  
  def opengraph_url
    "http://getcrave.com/items/#{self.friendly_id}"
  end
  
  def latitude
    self.restaurant.latitude
  end
  
  def longitude
    self.restaurant.longitude
  end
  
  def street_address
    self.restaurant.street_address
  end
  
  def restaurant_and_menu_item_name
    self.name + " @ " + self.restaurant.name
  end
  
  def image
    if (self.menu_item_photos.first)
      self.menu_item_photos.first.photo 
    else
      "http://getcrave.com/images/crave-text_50x50.png"
    end
  end
  
  def postal_code
    self.restaurant.zip
  end
  
  def country_name
    self.restaurant.country
  end
  
  def locality
    self.restaurant.city
  end
  
  def avg_rating
    self.menu_item_ratings.average(:rating)
  end
  
  def num_ratings
    self.menu_item_ratings.count
  end
  
end
