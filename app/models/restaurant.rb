class Restaurant < ActiveRecord::Base
  has_many :menu_items
  acts_as_mappable :default_units => :miles, 
                   :default_formula => :sphere, 
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
end
