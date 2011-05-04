class Restaurant < ActiveRecord::Base
  has_many :menu_items
  has_friendly_id :name, :use_slug => true
  acts_as_mappable :default_units => :miles, 
                   :default_formula => :sphere, 
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
end
