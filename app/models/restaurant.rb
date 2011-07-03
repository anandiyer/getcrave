class Restaurant < ActiveRecord::Base
  has_many :menu_items
  has_many :menu_item_ratings, :through => :menu_items
  has_friendly_id :name, :use_slug => true, :reserved_words => ["new", "edit", "details", "add"]
  acts_as_mappable :default_units => :miles, 
                   :default_formula => :sphere, 
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
  acts_as_opengraph :values => { :site_name => "crave", :type => "restaurant" },
    :columns => {
      :title => :name,
      :image => :image,
      :latitude => :latitude, 
      :longitude => :longitude,
      :street_address => :street_address,
      :locality => :city,
      :postal_code => :zip,
      :country_name => :country
  }
                   
  searchable do
      text :name, :default_boost => 6
      location :coordinates do
        Sunspot::Util::Coordinates.new(latitude, longitude)
      end
  end

  def address_full
    "#{street_address}, #{city}, #{state}, #{zip}"
  end

  def image
    "http://getcrave.com/images/crave-text_50x50.png"
  end
end