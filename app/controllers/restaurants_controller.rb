class RestaurantsController < ApplicationController

  layout "general"

  def index
    # @restaurants = Restaurant.find(:all, :origin => [37.77859, -122.39142], :within=>1)
    # @restaurants = Restaurant.find(:all, :origin => [37.77859, -122.39142], :order=>'distance asc', :limit => 25)
    # @restaurants = Restaurant.all

    get_closest_restaurants params[:lat], params[:long], params[:within], params[:limit]

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @restaurants }
      format.json { render :json => @restaurants }
    end
  end
  
  def details
    @restaurant = Restaurant.find_by_id(params[:id])

    respond_to do |format|
      format.json { render :json => @restaurant}
      format.xml  { render :xml => @restaurant }
    end
  end

  def show
    redirect_to restaurant_menu_items_path(params[:id])
  end

  # GET /restaurants/new
  # GET /restaurants/new.xml
  def new
    @restaurant = Restaurant.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @restaurant }
      format.json { render :json => @restaurant }
    end
  end

  # GET /restaurants/1/edit
  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  # POST /restaurants
  # POST /restaurants.xml
  def create
    @restaurant = Restaurant.new(params[:restaurant])

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to(@restaurant, :notice => 'Restaurant was successfully created.') }
        format.xml { render :xml => @restaurant, :status => :created, :location => @restaurant }
        format.json { render :json => @restaurant, :status => :created, :location => @restaurant }
      else
        format.html { render :action => "new" }
        format.xml { render :json => @restaurant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /restaurants/1
  # PUT /restaurants/1.xml
  def update
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      if @restaurant.update_attributes(params[:restaurant])
        format.html { redirect_to(@restaurant, :notice => 'Restaurant was successfully updated.') }
        format.xml { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @restaurant.errors, :status => :unprocessable_entity }
        format.json { render :xml => @restaurant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.xml
  def destroy
    # @restaurant = Restaurant.find(params[:id])
    # @restaurant.destroy

    respond_to do |format|
      format.html { redirect_to(restaurants_url) }
      format.xml { head :ok }
      format.json { head :ok }
    end
  end

  # Search
  def search

    if params[:lat] && !params[:lat].empty? && params[:long] && !params[:long].empty?
      @search = Sunspot.search(Restaurant) do
        fulltext(params[:q])
        with(:coordinates).near(params[:lat], params[:long], :precision => 3)
        # 6 and lower is the only precision that seems to work
      end
    else
      @search = Restaurant.search() do
        fulltext(params[:q])
      end
    end

    @restaurants = @search.results

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @restaurants }
      format.json { render :json => @restaurants }
    end
  end

  def show_restaurants_nearby
    get_closest_restaurants params[:lat], params[:long]
    render :partial => "restaurants_grouped_by_stars"
  end

  private
  def get_closest_restaurants lat, long, within, limit
    @lat = lat.to_f
    @long = long.to_f
    @within = 1
    @limit = 100

    if within && !within.empty?
      @within = within.to_f
    end
    
    if limit && !limit.empty?
      @limit = limit.to_i
    end
    
    @conditions = "distance < #{@within}"

    @restaurants = Restaurant.paginate(:all,
      :page => params[:page],
      :per_page => ITEMS_PER_PAGE,
      :origin => [@lat, @long],
      :conditions => @conditions,
      :order => 'distance asc', 
      :limit => @limit)
  end
end
