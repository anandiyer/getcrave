#require 'rmagick'
#require 'open-uri'
require "uuidtools"
#require 'RMagick'
#require 'fileutils'

# Monkey patching to include the 'distance' attribute in menu_items
module Geokit
  module Mappable
    def to_lat_lng
      return self if instance_of?(Geokit::LatLng) || instance_of?(Geokit::GeoLoc)
      if (self.class.name == 'Restaurant')
        return LatLng.new(self.send(self.class.lat_column_name),
          self.send(self.class.lng_column_name)) if self.class.respond_to?(:acts_as_mappable)
      else
        return LatLng.new(self.restaurant.send(self.restaurant.class.lat_column_name),
          self.restaurant.send(self.restaurant.class.lng_column_name)) if self.class.respond_to?(:acts_as_mappable)
      end
      nil
    end
  end 
end

class MenuItemsController < ApplicationController
  before_filter :get_restaurant, :except => :nearby_loading
  before_filter :signed_in?, :only => [:upload_photo]

  respond_to :js, :only => [:show_menu_items_of_place, :show_menu_items_nearby]

  layout "general", :except => [:admin]

  def admin
    params_4_index_and_show_menu_items_of_place

    respond_to do |format|
      format.html # admin.html.haml
      format.xml  { render :xml => @menu_items.to_xml(:include =>  [:restaurant, :menu_item_avg_rating_count, :menu_item_photos])}
      format.json  { render :json => @menu_items.to_json(:include => [:restaurant, :menu_item_avg_rating_count, :menu_item_photos]) }
    end
  end

  def nearby
    params_4_location_and_show_menu_item_nearby


    if !cookies[:lat] && !cookies[:long]
      how_much = 60
      cookies[:lat] = {
        :value => params[:lat],
        :expires => how_much.minutes.from_now.utc
      }

      cookies[:long] = {
        :value => params[:long],
        :expires => how_much.minutes.from_now.utc
      }
    end

    respond_to do |format|
      format.html # location.html.haml
      format.xml { render :xml => @menu_items.to_xml(:methods => :distance, :include => [:restaurant, :menu_item_avg_rating_count, :menu_item_photos]) }
      format.json { render :json => @menu_items.to_json(:methods => :distance, :include => [:restaurant, :menu_item_avg_rating_count, :menu_item_photos]) }
    end
  end

  def params_4_index_and_show_menu_items_of_place
    # TODO - handle restaurant = nil case
    # @restaurant = @restaurant ? @restaurant : Restaurant.find(params[:place_name])
    
    if !@restaurant && params[:place_name]
      @restaurant = Restaurant.find(params[:place_name])
    elsif params[:restaurant_id]
      @restaurant = Restaurant.find(params[:restaurant_id])
    end
    
    @conditions = "restaurants.id = #{@restaurant.id}"

    @menu_items = MenuItem.find(:all,
      :conditions => @conditions,
      :joins => " INNER JOIN restaurants ON restaurants.id = menu_items.restaurant_id LEFT OUTER JOIN menu_item_avg_rating_count ON menu_item_avg_rating_count.menu_item_id = menu_items.id",
      :order => "(menu_item_avg_rating_count.avg_rating IS NULL) ASC, menu_item_avg_rating_count.avg_rating DESC, LOWER(menu_items.name) ASC")

  end
  
  def food_by_foursquare_venue

    @foursquare_venue_id = params[:foursquare_venue_id]
    
    @conditions = "restaurants.foursquare_venue_id = \'#{@foursquare_venue_id}\'"
    
    @menu_item = MenuItem.find(:first, 
      :conditions => @conditions, 
      :joins => " INNER JOIN restaurants ON restaurants.id = menu_items.restaurant_ID LEFT OUTER JOIN menu_item_avg_rating_count ON menu_item_avg_rating_count.menu_item_id = menu_items.id",
      :order => "(menu_item_avg_rating_count.avg_rating IS NULL) ASC, menu_item_avg_rating_count.avg_rating DESC, menu_item_avg_rating_count.count DESC")

    if (@menu_item)
      respond_to do |format|
        format.xml  { render :xml => @menu_item.to_xml(:include =>  [:restaurant, :menu_item_avg_rating_count])}
        format.json  { render :json => @menu_item.to_json(:include => [:restaurant, :menu_item_avg_rating_count]) }
      end
    else
      respond_to do |format|
        format.xml  { head :ok }
        format.json  { head :ok }
      end
    end
    
  end

  # GET /menu_items
  # GET /menu_items.xml
  def index
    # Assuming that no menu has more than 500 items - this is the MAX
    @limit = 500 
    #ITEMS_PER_PAGE

    if params[:limit] && !params[:limit].empty?
      @limit = params[:limit].to_i
    end

    params_4_index_and_show_menu_items_of_place

    respond_to do |format|
      format.html # location.html.haml
      format.xml  { render :xml => @menu_items.to_xml(:include =>  [:restaurant, :menu_item_avg_rating_count, :menu_item_photos])}
      format.json  { render :json => @menu_items.to_json(:include => [:restaurant, :menu_item_avg_rating_count, :menu_item_photos]) }
      format.js  { render :partial => "/items_grouped_by_stars" }
    end
    
    # Now find the menu items for each of those restaurants
    #@menu_items = MenuItem.find(:all, 
      #:joins => " INNER JOIN restaurants ON restaurants.id = menu_items.restaurant_id")
      #:conditions => { :restaurants => { :origin => [@lat, @long], :order => 'distance asc', :limit => 5 } })
  end

  # GET /menu_items/1
  # GET /menu_items/1.xml

  def show
    params_4_show_n_show_reviews

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @menu_item.to_xml( :include => {:restaurant => {}, 
        :menu_item_avg_rating_count => {}, 
        :menu_item_ratings => {:include => :user},
        :menu_item_photos => {},
        :menu_label_associations => {}, } ) }
      format.json { render :json => @menu_item.to_json( :include => {:restaurant => {}, 
        :menu_item_avg_rating_count => {}, 
        :menu_item_ratings => {:include => :user},
        :menu_item_photos => {},
        :menu_label_associations => {:include => :menu_label}, } ) }
    end
  end

#
##  menu items photo upload
#  def upload_photo
#    if params[:file] && (params[:file].content_type.to_s.index("image") == 0 )
#      temp_file = params[:file].tempfile
#      name = UUIDTools::UUID.random_create.to_s+".jpg" #renerating uniq name
#      directory = RAILS_ROOT+MENU_ITEMS_PHOTOS_PATH
#      path = File.join(directory, name)
#      File.open(path, "wb") { |f| f.write(temp_file.read)}
#
#      render :nothing => true, :status => 200
#    else
#      raise "wrong type of file"
#    end
#  end

  def upload_photo
    if params[:file] && (params[:file].content_type.to_s.index("image") == 0 )
        temp_file = params[:file].tempfile

        filename = UUIDTools::UUID.random_create.to_s+".jpg"

#        thumb_name = "menu_items_"+params[:id]

#        croped_image
#        img = Magick::Image.read(params[:file].tempfile.path).first
#        thumbnail = img.thumbnail(141,141)
#        thumbnail.write "public/"+thumb_name+".png"

#        if !session[thumb_name]
#          session[:thumb_name] = "have thumbnail"
#
#          AWS::S3::S3Object.store(thumb_name, thumbnail, BUCKET, :access => :public_read)
#          p thumb_url = AWS::S3::S3Object.url_for(thumb_name, BUCKET, :authenticated => false)
#        end

         AWS::S3::S3Object.store(filename, temp_file.read, BUCKET, :access => :public_read)
         p url = AWS::S3::S3Object.url_for(filename, BUCKET, :authenticated => false)


        if params[:uuid] == "undefined"
          menu_item_photo = MenuItemPhoto.new
          menu_item_photo.menu_item_id = params[:id]
          menu_item_photo.user_id = current_user.id if current_user
          menu_item_photo.photo = url
          menu_item = MenuItem.find_by_id(params[:id])
          menu_item.menu_item_photos << menu_item_photo

          render :partial => "gallery_link"
        else
#          temp = TempImage.new
#          temp.hash = params[:uuid].to_s
#          temp.image_name = filename.to_s
#          temp.save did not work (())
#          TODO: Anand? can you refactor me?

          TempImage.find_by_sql("INSERT INTO temp_images(hash, image_name) VALUES ('"+params[:uuid]+"', '"+url+"')")

          render :nothing => true
#          temp.save
        end
      else
#        plupload can filter file types
        raise "wrong type of file"
      end

  end


  def show_reviews
    params_4_show_n_show_reviews
    render :partial => "review"
  end


  def show_menu_items_of_place
    params_4_index_and_show_menu_items_of_place
    render :partial => "/items_grouped_by_stars"
  end

  def show_menu_items_nearby
    params_4_location_and_show_menu_item_nearby
    render :partial => "/items_grouped_by_stars"
  end

  # GET /menu_items/new
  # GET /menu_items/new.xml
  def new
    @menu_item = MenuItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @menu_item }
      format.json { render :json => @menu_item }
    end
  end

  # GET /menu_items/1/edit
  def edit
    @menu_item = MenuItem.find(params[:id])
  end

  # POST /menu_items
  # POST /menu_items.xml
  def create
    uuid = params[:menu_item][:uuid]
    params[:menu_item].delete("uuid")



    @menu_item = MenuItem.new(params[:menu_item])

    respond_to do |format|
      if @menu_item.save
        if (params[:dish] && params[:dish][:label] && !params[:dish][:label].empty?)
          labels = params[:dish][:label].gsub(/ /,"").split(",").delete_if{|l| l.size <2}.uniq
          labels_ids = MenuLabel.where(:menu_label => labels).select("id").map{|i| i.id}

          labels_ids.each do |label_id|
            ma = MenuLabelAssociation.new
            ma.menu_item_id = @menu_item.id
            ma.menu_label_id = label_id
            ma.user_id = current_user.id
            ma.save
          end
        end 

        photos = TempImage.where(:hash => uuid)
        photos.map{|ph| ph.image_name}.each do |p|
          mip = MenuItemPhoto.new
          mip.menu_item_id = @menu_item.id
          mip.photo = p
          mip.user_id = current_user.id
          mip.save
        end
        photos.delete_all

#        format.html { redirect_to(@menu_item, :notice => 'Menu item was successfully created.') }
        format.xml  { render :xml => @menu_item, :status => :created, :location => @menu_item }
        format.json { render :json => @menu_item, :status => :created, :location => @menu_item }
        format.js  { render :js => "window.update_after_adding_item("+params[:menu_item][:restaurant_id].to_s+")"}
      end
    end
  end

  # PUT /menu_items/1
  # PUT /menu_items/1.xml
  def update
    @menu_item = MenuItem.find(params[:id])

    respond_to do |format|
      if @menu_item.update_attributes(params[:menu_item])
        format.html { redirect_to(@menu_item, :notice => 'Menu item was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menu_item.errors, :status => :unprocessable_entity }
        format.json  { render :json => @menu_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_items/1
  # DELETE /menu_items/1.xml
  def destroy
    
    @menu_item = MenuItem.find(params[:id])
    @menu_item.destroy

    respond_to do |format|
      format.html { redirect_to(menu_items_url) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end
  
  # Search
  def search
    if params[:lat] && !params[:lat].empty? && params[:long] && !params[:long].empty?

      @search = MenuItem.search() do
        fulltext(params[:q])
        # 6 and lower is the only precision that seems to work
        with(:coordinates).near(params[:lat], params[:long], :precision => 5)
        # , :boost => 2, :precision => 6)
      end
    else
      @search = MenuItem.search() do
        fulltext(params[:q])
      end
    end

    @menu_items = @search.results
      
    respond_to do |format|
        format.html # search.html.erb
        format.xml  { render :xml => @menu_items.to_xml(:include =>  [:restaurant, :menu_item_avg_rating_count, :menu_item_photos])}
        format.json  { render :json => @menu_items.to_json(:include => [:restaurant, :menu_item_avg_rating_count, :menu_item_photos]) }
    end
  end

  private
  def get_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id]) unless params[:restaurant_id].blank?
  end

  def params_4_show_n_show_reviews
    @foodies_for_current_dish = User.find(:all,
      :order => 'user_ratings_count DESC',
      :limit => ITEMS_PER_PAGE)

    #FIXME - need to get all the menu item attributes like ratings, photos etc.
    @menu_item = MenuItem.find(params[:id], 
      :include => [:restaurant, :menu_item_avg_rating_count, :menu_item_ratings, :menu_item_photos])

  end

  def params_4_location_and_show_menu_item_nearby
    @lat = params[:lat].to_f
    @long = params[:long].to_f
    @within = 0.5
    @limit = 100
    
    if params[:limit] && !params[:limit].empty?
      @limit = params[:limit].to_i
    end
    
    if params[:within] && !params[:within].empty?
      @within = params[:within].to_f
    end
    
    @conditions = "distance < #{@within}"
    
    # Lookup all the restaurants near the given lat/long and get 25 of the menu_items
    # and order by rating
    
    #FIXME - order by rating based on QS
    @origin = [@lat, @long]
    @menu_items = MenuItem.paginate(:all,
         :page => params[:page],
         :per_page => ITEMS_PER_PAGE,
         :origin => @origin,
         :conditions => @conditions,
         :joins => " LEFT OUTER JOIN menu_item_avg_rating_count ON menu_item_avg_rating_count.menu_item_id = menu_items.id",
         :order => "(menu_item_avg_rating_count.avg_rating IS NULL) ASC, menu_item_avg_rating_count.avg_rating DESC, menu_item_avg_rating_count.count DESC, distance ASC",
         # :include => :menu_item_avg_rating_count, 
         :limit => @limit)

    if (params[:distance].eql?("yes"))
      # We have to add this to get the 'distance' and this also
      # sorts by distance as opposed to by rating
      @menu_items.sort_by_distance_from(@origin)
      # FIXME: Re-sort by star rating
    end
  end
end
