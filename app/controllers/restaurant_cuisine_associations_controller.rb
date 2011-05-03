class RestaurantCuisineAssociationsController < ApplicationController
  # GET /restaurant_cuisine_associations
  # GET /restaurant_cuisine_associations.xml
  def index
    @restaurant_cuisine_associations = RestaurantCuisineAssociation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @restaurant_cuisine_associations }
    end
  end

  # GET /restaurant_cuisine_associations/1
  # GET /restaurant_cuisine_associations/1.xml
  def show
    @restaurant_cuisine_association = RestaurantCuisineAssociation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @restaurant_cuisine_association }
    end
  end

  # GET /restaurant_cuisine_associations/new
  # GET /restaurant_cuisine_associations/new.xml
  def new
    @restaurant_cuisine_association = RestaurantCuisineAssociation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @restaurant_cuisine_association }
    end
  end

  # GET /restaurant_cuisine_associations/1/edit
  def edit
    @restaurant_cuisine_association = RestaurantCuisineAssociation.find(params[:id])
  end

  # POST /restaurant_cuisine_associations
  # POST /restaurant_cuisine_associations.xml
  def create
    @restaurant_cuisine_association = RestaurantCuisineAssociation.new(params[:restaurant_cuisine_association])

    respond_to do |format|
      if @restaurant_cuisine_association.save
        format.html { redirect_to(@restaurant_cuisine_association, :notice => 'Restaurant cuisine association was successfully created.') }
        format.xml  { render :xml => @restaurant_cuisine_association, :status => :created, :location => @restaurant_cuisine_association }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @restaurant_cuisine_association.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /restaurant_cuisine_associations/1
  # PUT /restaurant_cuisine_associations/1.xml
  def update
    @restaurant_cuisine_association = RestaurantCuisineAssociation.find(params[:id])

    respond_to do |format|
      if @restaurant_cuisine_association.update_attributes(params[:restaurant_cuisine_association])
        format.html { redirect_to(@restaurant_cuisine_association, :notice => 'Restaurant cuisine association was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @restaurant_cuisine_association.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurant_cuisine_associations/1
  # DELETE /restaurant_cuisine_associations/1.xml
  def destroy
    @restaurant_cuisine_association = RestaurantCuisineAssociation.find(params[:id])
    @restaurant_cuisine_association.destroy

    respond_to do |format|
      format.html { redirect_to(restaurant_cuisine_associations_url) }
      format.xml  { head :ok }
    end
  end
end
