class MenuItemRatingHelpfulsController < ApplicationController
  # GET /menu_item_rating_helpfuls
  # GET /menu_item_rating_helpfuls.xml
  def index
    @menu_item_rating_helpfuls = MenuItemRatingHelpful.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @menu_item_rating_helpfuls }
    end
  end

  # GET /menu_item_rating_helpfuls/1
  # GET /menu_item_rating_helpfuls/1.xml
  def show
    @menu_item_rating_helpful = MenuItemRatingHelpful.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @menu_item_rating_helpful }
    end
  end

  # GET /menu_item_rating_helpfuls/new
  # GET /menu_item_rating_helpfuls/new.xml
  def new
    @menu_item_rating_helpful = MenuItemRatingHelpful.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @menu_item_rating_helpful }
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
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @menu_item_rating_helpful.errors, :status => :unprocessable_entity }
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
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menu_item_rating_helpful.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_item_rating_helpfuls/1
  # DELETE /menu_item_rating_helpfuls/1.xml
  def destroy
    @menu_item_rating_helpful = MenuItemRatingHelpful.find(params[:id])
    @menu_item_rating_helpful.destroy

    respond_to do |format|
      format.html { redirect_to(menu_item_rating_helpfuls_url) }
      format.xml  { head :ok }
    end
  end
end
