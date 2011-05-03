class RestaurantCuisinesController < ApplicationController
  # GET /restaurant_cuisines
  # GET /restaurant_cuisines.xml
  def index
    @restaurant_cuisines = RestaurantCuisine.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @restaurant_cuisines }
    end
  end

  # GET /restaurant_cuisines/1
  # GET /restaurant_cuisines/1.xml
  def show
    @restaurant_cuisine = RestaurantCuisine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @restaurant_cuisine }
    end
  end

  # GET /restaurant_cuisines/new
  # GET /restaurant_cuisines/new.xml
  def new
    @restaurant_cuisine = RestaurantCuisine.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @restaurant_cuisine }
    end
  end

  # GET /restaurant_cuisines/1/edit
  def edit
    @restaurant_cuisine = RestaurantCuisine.find(params[:id])
  end

  # POST /restaurant_cuisines
  # POST /restaurant_cuisines.xml
  def create
    @restaurant_cuisine = RestaurantCuisine.new(params[:restaurant_cuisine])

    respond_to do |format|
      if @restaurant_cuisine.save
        format.html { redirect_to(@restaurant_cuisine, :notice => 'Restaurant cuisine was successfully created.') }
        format.xml  { render :xml => @restaurant_cuisine, :status => :created, :location => @restaurant_cuisine }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @restaurant_cuisine.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /restaurant_cuisines/1
  # PUT /restaurant_cuisines/1.xml
  def update
    @restaurant_cuisine = RestaurantCuisine.find(params[:id])

    respond_to do |format|
      if @restaurant_cuisine.update_attributes(params[:restaurant_cuisine])
        format.html { redirect_to(@restaurant_cuisine, :notice => 'Restaurant cuisine was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @restaurant_cuisine.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurant_cuisines/1
  # DELETE /restaurant_cuisines/1.xml
  def destroy
    @restaurant_cuisine = RestaurantCuisine.find(params[:id])
    @restaurant_cuisine.destroy

    respond_to do |format|
      format.html { redirect_to(restaurant_cuisines_url) }
      format.xml  { head :ok }
    end
  end
end
