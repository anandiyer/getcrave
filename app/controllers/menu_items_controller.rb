require "uuidtools"

# Monkey patching to include the 'distance' attribute in menu_items
module Geokit
  module Mappable
    def to_lat_lng
      return self if instance_of?(Geokit::LatLng) || instance_of?(Geokit::GeoLoc)
      return LatLng.new(self.restaurant.send(self.restaurant.class.lat_column_name),
        self.restaurant.send(self.restaurant.class.lng_column_name)) if self.class.respond_to?(:acts_as_mappable)
      nil
    end
  end 
end

class MenuItemsController < ApplicationController
  before_filter :get_restaurant
  layout "general"

  @@BUCKET = "my_image_bucket"


  def location

    params_4_location_and_show_menu_item_nearby

    respond_to do |format|
      format.html # location.html.haml
      format.xml { render :xml => @menu_items.to_xml(:methods => :distance, :include => [:restaurant, :menu_item_avg_rating_count]) }
      format.json { render :json => @menu_items.to_json(:methods => :distance, :include => [:restaurant, :menu_item_avg_rating_count]) }
    end
  end

  # GET /menu_items
  # GET /menu_items.xml
  def index
    # Assuming that no menu has more than 500 items - this is the MAX
    @limit = 500
    
    if params[:limit] && !params[:limit].empty?
      @limit = params[:limit].to_i
    end

    # FIXME - handle restaurant = nil case 
    @menu_items = MenuItem.find_by_sql(["SELECT menu_items.* FROM menu_items
    LEFT OUTER JOIN menu_item_avg_rating_count ON menu_item_avg_rating_count.menu_item_id = menu_items.id
    WHERE menu_items.restaurant_id = ? 
    ORDER BY (menu_item_avg_rating_count.avg_rating IS NULL) ASC, menu_item_avg_rating_count.avg_rating DESC",
    @restaurant.id])
    
    respond_to do |format|
      format.html # location.html.haml
      format.xml  { render :xml => @menu_items.to_xml(:include =>  [:restaurant, :menu_item_avg_rating_count])}
      format.json  { render :json => @menu_items.to_json(:include => [:restaurant, :menu_item_avg_rating_count]) }
    end
    
    # Now find the menu items for each of those restaurants
    #@menu_items = MenuItem.find(:all, 
      #:joins => " INNER JOIN restaurants ON restaurants.id = menu_items.restaurant_id")
      #:conditions => { :restaurants => { :origin => [@lat, @long], :order => 'distance asc', :limit => 5 } })

  end

  # GET /menu_items/1
  # GET /menu_items/1.xml
  def show

    @foodies_for_current_dish = User.find(:all, 
      :order => 'user_ratings_count DESC', 
      :limit => 5)
    
    #FIXME - need to get all the menu item attributes like ratings, photos etc.
    @menu_item = MenuItem.find(params[:id],
      :include => [:restaurant, :menu_item_avg_rating_count, :menu_item_ratings])
    
    respond_to do |format|
      format.html # _unused_show.html.haml
      format.xml  { render :xml => @menu_item.to_xml( :include => [ :restaurant, :menu_item_avg_rating_count, :menu_item_ratings ] ) }
      format.json { render :json => @menu_item.to_json( :include => [ :restaurant, :menu_item_avg_rating_count, :menu_item_ratings ] ) }
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
    if signed_in?
      if params[:file] && (params[:file].content_type.to_s.index("image") == 0 )
        temp_file = params[:file].tempfile
        filename = UUIDTools::UUID.random_create.to_s+".jpg"

        AWS::S3::S3Object.store(filename, temp_file.read, @@BUCKET, :access => :public_read)
        url = AWS::S3::S3Object.url_for(filename, @@BUCKET, :authenticated => false)

        menu_item_photo = MenuItemPhoto.new

        menu_item_photo.menu_item_id = params[:id]
        menu_item_photo.user_id = current_user.id
        menu_item_photo.photo = filename

        menu_item = MenuItem.find(params[:id])
        menu_item.menu_item_photos << menu_item_photo


        render :text => menu_item.menu_item_photos.count
      else
#        plupload can filter file types
        raise "wrong type of file"
      end



    else
      raise "not signed in"
    end
  end



  def show_reviews
    show
    render :partial => "review"
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
    @menu_item = MenuItem.new(params[:menu_item])

    respond_to do |format|
      if @menu_item.save
        format.html { redirect_to(@menu_item, :notice => 'Menu item was successfully created.') }
        format.xml  { render :xml => @menu_item, :status => :created, :location => @menu_item }
        format.json  { render :json => @menu_item, :status => :created, :location => @menu_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @menu_item.errors, :status => :unprocessable_entity }
        format.json  { render :json => @menu_item.errors, :status => :unprocessable_entity }
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
    # @menu_item = MenuItem.find(params[:id])
    # @menu_item.destroy

    respond_to do |format|
      format.html { redirect_to(menu_items_url) }
      format.xml  { head :ok }
    end
  end
  
  # Search
  def search
    if params[:lat] && !params[:lat].empty? && params[:long] && !params[:long].empty?
      @lat = params[:lat].to_f
      @long = params[:long].to_f

      @search = MenuItem.search() do
        fulltext(params[:q])
        # 6 and lower is the only precision that seems to work
        with(:coordinates).near(@lat, @long, :precision => 5)
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
        format.xml  { render :xml => @menu_items.to_xml(:include =>  [:restaurant, :menu_item_avg_rating_count])}
        format.json  { render :json => @menu_items.to_json(:include => [:restaurant, :menu_item_avg_rating_count]) }
      end
  end

  private
  def get_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id]) unless params[:restaurant_id].blank?
  end

  def params_4_location_and_show_menu_item_nearby
    if params[:lat]
      @lat = params[:lat].to_f
      @long = params[:long].to_f
    else
      @lat = 40.761447
      @long = -73.969456
    end

    @limit = 5

    if params[:limit] && !params[:limit].empty?
      @limit = params[:limit].to_i
    end

    # Lookup all the restaurants near the given lat/long and get 25 of the menu_items
    # and order by rating

    #FIXME - assuming within 3 mile radius by default
    #FIXME - order by rating based on QS
    @origin = [@lat, @long]
    @menu_items = MenuItem.find(:all,
                                :origin => @origin,
                                :conditions => "distance < 3",
                                :joins => " LEFT OUTER JOIN menu_item_avg_rating_count ON menu_item_avg_rating_count.menu_item_id = menu_items.id",
                                :order => "(menu_item_avg_rating_count.avg_rating IS NULL) ASC, menu_item_avg_rating_count.avg_rating DESC",
                                # :include => :menu_item_avg_rating_count,
                                :limit => @limit)

    # We have to add this to get the 'distance' field
    @menu_items.sort_by_distance_from(@origin)

  end
end
