class RestaurantLabelsController < ApplicationController
  # GET /restaurant_labels
  # GET /restaurant_labels.xml
  def index
    @restaurant_labels = RestaurantLabel.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @restaurant_labels }
    end
  end

  # GET /restaurant_labels/1
  # GET /restaurant_labels/1.xml
  def show
    @restaurant_label = RestaurantLabel.find(params[:id])

    respond_to do |format|
      format.html # _unused_show.html.haml
      format.xml  { render :xml => @restaurant_label }
    end
  end

  # GET /restaurant_labels/new
  # GET /restaurant_labels/new.xml
  def new
    @restaurant_label = RestaurantLabel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @restaurant_label }
    end
  end

  # GET /restaurant_labels/1/edit
  def edit
    @restaurant_label = RestaurantLabel.find(params[:id])
  end

  # POST /restaurant_labels
  # POST /restaurant_labels.xml
  def create
    @restaurant_label = RestaurantLabel.new(params[:restaurant_label])

    respond_to do |format|
      if @restaurant_label.save
        format.html { redirect_to(@restaurant_label, :notice => 'Restaurant label was successfully created.') }
        format.xml  { render :xml => @restaurant_label, :status => :created, :location => @restaurant_label }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @restaurant_label.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /restaurant_labels/1
  # PUT /restaurant_labels/1.xml
  def update
    @restaurant_label = RestaurantLabel.find(params[:id])

    respond_to do |format|
      if @restaurant_label.update_attributes(params[:restaurant_label])
        format.html { redirect_to(@restaurant_label, :notice => 'Restaurant label was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @restaurant_label.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurant_labels/1
  # DELETE /restaurant_labels/1.xml
  def destroy
    @restaurant_label = RestaurantLabel.find(params[:id])
    @restaurant_label.destroy

    respond_to do |format|
      format.html { redirect_to(restaurant_labels_url) }
      format.xml  { head :ok }
    end
  end
end
