class MenuItemsController < ApplicationController
  before_filter :get_restaurant

  def location
    @lat = params[:lat].to_f
    @long = params[:long].to_f
    @limit = 25
    
    if params[:limit] && !params[:limit].empty?
      @limit = params[:limit].to_i
    end
    
    # Lookup all the restaurants near the given lat/long and get 25 of the menu_items
    # and order by rating
    
    #FIXME - need to join to return average menu_item_rating for each menu_item
    #FIXME - assuming within 3 mile radius by default
    #FIXME - also distance virtual column/field is currently being dropped because
    # of a GeoKit problem
    #FIXME - order by rating based on QS
     @menu_items = MenuItem.find(:all, 
          :origin => [@lat, @long], 
          :conditions => "distance < 3",
          :order => "distance asc",
          # :include => :menu_item_avg_rating_count, 
          :limit => @limit)
          
    # @menu_items.restaurant.sort_by_distance_from(:origin => [@lat, @long])
      
     # @menu_items = []
     #@restaurants.each do |r|
      #@item = {}
       #@item = r.menu_items.find(:all, :include => [:menu_item_avg_rating_count, :restaurant])
       # @item(:restaurant_name => r.name)
       # @item(:distance => r.distance)
       #@menu_items << @item
      
      respond_to do |format|
        format.html # location.html.erb
        format.xml  { render :xml => @menu_items.to_xml(:include =>  [:restaurant, :menu_item_avg_rating_count])}
        format.json  { render :json => @menu_items.to_json(:include => [:restaurant, :menu_item_avg_rating_count]) }
      end
  end 

  # GET /menu_items
  # GET /menu_items.xml
  def index
    # @menu_items = MenuItem.all
    
    # Assuming that no menu has more than 500 items - this is the MAX
    @limit = 500
    
    if params[:limit] && !params[:limit].empty?
      @limit = params[:limit].to_i
    end

    # FIXME - handle restaurant = nil case 
    @menu_items = @restaurant.menu_items.find(:all, :limit => @limit)
        
    respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @menu_items }
          format.json { render :json => @menu_items }
    end
    
    # Now find the menu items for each of those restaurants
    #@menu_items = MenuItem.find(:all, 
      #:joins => " INNER JOIN restaurants ON restaurants.id = menu_items.restaurant_id")
      #:conditions => { :restaurants => { :origin => [@lat, @long], :order => 'distance asc', :limit => 5 } })

  end

  # GET /menu_items/1
  # GET /menu_items/1.xml
  def show
    #FIXME - need to get all the menu item attributes like ratings, photos etc.
    @menu_item = MenuItem.find(params[:id], :include => [:restaurant, :menu_item_avg_rating_count, :menu_item_ratings])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @menu_item.to_xml( :include => [ :restaurant, :menu_item_avg_rating_count, :menu_item_ratings ] ) }
      format.json { render :json => @menu_item.to_json( :include => [ :restaurant, :menu_item_avg_rating_count, :menu_item_ratings ] ) }
    end
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
      @search  = MenuItem.search() do
        fulltext(params[:q])
      end
      
      @menu_items = @search.results
      
      respond_to do |format|
        format.html # search.html.erb
        format.xml  { render :xml => @menu_items }
        format.json { render :json => @menu_items }
      end
  end
  
  private
    def get_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id]) unless params[:restaurant_id].blank?
    end
end
