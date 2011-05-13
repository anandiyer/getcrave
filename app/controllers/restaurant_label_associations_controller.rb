class RestaurantLabelAssociationsController < ApplicationController
  # GET /restaurant_label_associations
  # GET /restaurant_label_associations.xml
  def index
    @restaurant_label_associations = RestaurantLabelAssociation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @restaurant_label_associations }
    end
  end

  # GET /restaurant_label_associations/1
  # GET /restaurant_label_associations/1.xml
  def show
    @restaurant_label_association = RestaurantLabelAssociation.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @restaurant_label_association }
    end
  end

  # GET /restaurant_label_associations/new
  # GET /restaurant_label_associations/new.xml
  def new
    @restaurant_label_association = RestaurantLabelAssociation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @restaurant_label_association }
    end
  end

  # GET /restaurant_label_associations/1/edit
  def edit
    @restaurant_label_association = RestaurantLabelAssociation.find(params[:id])
  end

  # POST /restaurant_label_associations
  # POST /restaurant_label_associations.xml
  def create
    @restaurant_label_association = RestaurantLabelAssociation.new(params[:restaurant_label_association])

    respond_to do |format|
      if @restaurant_label_association.save
        format.html { redirect_to(@restaurant_label_association, :notice => 'Restaurant label association was successfully created.') }
        format.xml  { render :xml => @restaurant_label_association, :status => :created, :location => @restaurant_label_association }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @restaurant_label_association.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /restaurant_label_associations/1
  # PUT /restaurant_label_associations/1.xml
  def update
    @restaurant_label_association = RestaurantLabelAssociation.find(params[:id])

    respond_to do |format|
      if @restaurant_label_association.update_attributes(params[:restaurant_label_association])
        format.html { redirect_to(@restaurant_label_association, :notice => 'Restaurant label association was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @restaurant_label_association.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurant_label_associations/1
  # DELETE /restaurant_label_associations/1.xml
  def destroy
    @restaurant_label_association = RestaurantLabelAssociation.find(params[:id])
    @restaurant_label_association.destroy

    respond_to do |format|
      format.html { redirect_to(restaurant_label_associations_url) }
      format.xml  { head :ok }
    end
  end
end
