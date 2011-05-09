class MenuItemsController < ApplicationController
  before_filter :get_restaurant

  # GET /menu_items
  # GET /menu_items.xml
  def index
    # @menu_items = MenuItem.all

    @lat = params[:lat].to_f
    @long = params[:long].to_f
    @limit = 200
    
    if params[:limit] && !params[:limit].empty?
      @limit = params[:limit].to_i
    end

    # FIXME - lat & long could be specified erroneously as could the restaurant_id
    if (@lat == 0 || @long == 0)
      @menu_items = @restaurant.menu_items.find(:all, :limit => @limit)
    else 
      # Lookup all the restaurants near the given lat/long and get 50 of the menu_items
      @menu_items = Restaurant.find(:all, 
        :origin => [@lat, @long], 
        :order=>'distance asc',  
        :joins => [ :menu_items ],
        :limit => @limit)
    end
    
    # Now find the menu items for each of those restaurants
    #@menu_items = MenuItem.find(:all, 
      #:joins => " INNER JOIN restaurants ON restaurants.id = menu_items.restaurant_id")
      #:conditions => { :restaurants => { :origin => [@lat, @long], :order => 'distance asc', :limit => 5 } })

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @menu_items }
      format.json { render :json => @menu_items }
    end
  end

  # GET /menu_items/1
  # GET /menu_items/1.xml
  def show
    @menu_item = MenuItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @menu_item }
      format.json { render :json => @menu_item }
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
        format.xml  { render :xml => @restaurants }
        format.json { render :json => @restaurants }
      end
  end
  
  private
    def get_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id]) unless params[:restaurant_id].blank?
    end
end
