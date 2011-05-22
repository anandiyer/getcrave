class Restaurant < ActiveRecord::Base
  has_many :menu_items
  has_many :menu_item_ratings, :through => :menu_items
  has_friendly_id :name, :use_slug => true
  acts_as_mappable :default_units => :miles, 
                   :default_formula => :sphere, 
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
  searchable do
      text :name
      location :coordinates do
        Sunspot::Util::Coordinates.new(latitude, longitude)
      end
  end

end