class MenuItemRatingHelpfulsController < ApplicationController
  before_filter :get_menu_item_rating
  
  # GET /menu_item_rating_helpfuls
  # GET /menu_item_rating_helpfuls.xml
  def index
    if (@menu_item_rating)
      @menu_item_rating_helpfuls = @menu_item_rating.menu_item_rating_helpfuls.find(:all)
    else 
      @menu_item_rating_helpfuls = MenuItemRatingHelpful.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @menu_item_rating_helpfuls }
      format.json  { render :json => @menu_item_rating_helpfuls }
    end
  end

  # GET /menu_item_rating_helpfuls/1
  # GET /menu_item_rating_helpfuls/1.xml
  def show
    @menu_item_rating_helpful = MenuItemRatingHelpful.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @menu_item_rating_helpful }
      format.json  { render :json => @menu_item_rating_helpful }
    end
  end

  # GET /menu_item_rating_helpfuls/new
  # GET /menu_item_rating_helpfuls/new.xml
  def new
    @menu_item_rating_helpful = MenuItemRatingHelpful.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @menu_item_rating_helpful }
      format.json  { render :json => @menu_item_rating_helpful }
    end
  end
  
  def count
    #FIXME - account for @menu_item_rating = null
    @menu_item_rating_helpfuls_count = @menu_item_rating.menu_item_rating_helpfuls.find(:all).count
    
    respond_to do |format|
      format.json  { render :json => @menu_item_rating_helpfuls_count }
    end
  end

  # GET /menu_item_rating_helpfuls/1/edit
  def edit
    @menu_item_rating_helpful = MenuItemRatingHelpful.find(params[:id])
  end

  # POST /menu_item_rating_helpfuls
  # POST /menu_item_rating_helpfuls.xml
  def create
    @menu_item_rating_helpful = MenuItemRatingHelpful.new(params[:menu_item_rating_helpful])

    respond_to do |format|
      if @menu_item_rating_helpful.save
        format.html { redirect_to(@menu_item_rating_helpful, :notice => 'Menu item rating helpful was successfully created.') }
        format.xml  { render :xml => @menu_item_rating_helpful, :status => :created, :location => @menu_item_rating_helpful }
        format.json  { render :json => @menu_item_rating_helpful, :status => :created, :location => @menu_item_rating_helpful }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @menu_item_rating_helpful.errors, :status => :unprocessable_entity }
        format.json  { render :json => @menu_item_rating_helpful.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /menu_item_rating_helpfuls/1
  # PUT /menu_item_rating_helpfuls/1.xml
  def update
    @menu_item_rating_helpful = MenuItemRatingHelpful.find(params[:id])

    respond_to do |format|
      if @menu_item_rating_helpful.update_attributes(params[:menu_item_rating_helpful])
        format.html { redirect_to(@menu_item_rating_helpful, :notice => 'Menu item rating helpful was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menu_item_rating_helpful.errors, :status => :unprocessable_entity }
        format.json  { render :json => @menu_item_rating_helpful.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_item_rating_helpfuls/1
  # DELETE /menu_item_rating_helpfuls/1.xml
  def destroy
    # @menu_item_rating_helpful = MenuItemRatingHelpful.find(params[:id])
    # @menu_item_rating_helpful.destroy

    respond_to do |format|
      format.html { redirect_to(menu_item_rating_helpfuls_url) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end
  
  private
    def get_menu_item_rating
      @menu_item_rating = MenuItemRating.find(params[:menu_item_rating_id]) unless params[:menu_item_rating_id].blank?
    end
end
