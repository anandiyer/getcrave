class MenuItemRatingsController < ApplicationController
  before_filter :get_menu_item
  
  # GET /menu_items_ratings/avg_rating
  def avg_rating
    average = @menu_item.menu_item_ratings.average(:rating)
    count = @menu_item.menu_item_ratings.count
    
    @response = { :average => average, :count => count}
        
    respond_to do |format|
      format.json { render :json => @response.to_json }
    end 
  end
  
  # GET /menu_item_ratings
  # GET /menu_item_ratings.xml
  def index
    #@menu_item_ratings = MenuItemRating.all
   
    @menu_item_ratings = @menu_item.menu_item_ratings.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @menu_item_ratings }
      format.json { render :json => @menu_item_ratings }
    end
  end

  # GET /menu_item_ratings/1
  # GET /menu_item_ratings/1.xml
  def show
    #@menu_item_rating = @menu_item.menu_item_ratings.find(params[:id])

    @menu_item_rating = MenuItemRating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @menu_item_rating }
      format.json { render :json => @menu_item_rating }
    end
  end

  # GET /menu_item_ratings/new
  # GET /menu_item_ratings/new.xml
  def new
    @menu_item_rating = MenuItemRating.new
    @menu_item_rating.menu_item_id = @menu_item.id

    respond_to do |format|
      # FIXME
      format.html # new.html.erb
      format.xml  { render :xml => @menu_item_rating }
      format.json { render :json => @menu_item_rating }
    end
  end

  # GET /menu_item_ratings/1/edit
  def edit
    @menu_item_rating = MenuItemRating.find(params[:id])
  end

  # POST /menu_item_ratings
  # POST /menu_item_ratings.xml
  def create
    @menu_item_rating = MenuItemRating.new(params[:menu_item_rating])

    respond_to do |format|
      if @menu_item_rating.save
        format.html { redirect_to(@menu_item_rating, :notice => 'Menu item rating was successfully created.') }
        format.xml  { render :xml => @menu_item_rating, :status => :created, :location => @menu_item_rating }
        format.json  { render :json => @menu_item_rating, :status => :created, :location => @menu_item_rating }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @menu_item_rating.errors, :status => :unprocessable_entity }
        format.json  { render :json => @menu_item_rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /menu_item_ratings/1
  # PUT /menu_item_ratings/1.xml
  def update
    @menu_item_rating = MenuItemRating.find(params[:id])

    respond_to do |format|
      if @menu_item_rating.update_attributes(params[:menu_item_rating])
        format.html { redirect_to(@menu_item_rating, :notice => 'Menu item rating was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menu_item_rating.errors, :status => :unprocessable_entity }
        format.json  { render :json => @menu_item_rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_item_ratings/1
  # DELETE /menu_item_ratings/1.xml
  def destroy
    @menu_item_rating = MenuItemRating.find(params[:id])
    @menu_item_rating.destroy

    respond_to do |format|
      format.html { redirect_to(menu_item_ratings_url) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end
  
  private
    def get_menu_item
      @menu_item = MenuItem.find(params[:menu_item_id]) unless params[:menu_item_id].blank?
    end
  
end
