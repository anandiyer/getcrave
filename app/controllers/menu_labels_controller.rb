class MenuLabelsController < ApplicationController
  # GET /menu_labels
  # GET /menu_labels.xml
  def index
    @menu_labels = MenuLabel.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @menu_labels }
    end
  end

  # GET /menu_labels/1
  # GET /menu_labels/1.xml
  def show
    @menu_label = MenuLabel.find(params[:id])

    respond_to do |format|
      format.html # _unused_show.html.haml
      format.xml  { render :xml => @menu_label }
    end
  end

  # GET /menu_labels/new
  # GET /menu_labels/new.xml
  def new
    @menu_label = MenuLabel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @menu_label }
    end
  end

  # GET /menu_labels/1/edit
  def edit
    @menu_label = MenuLabel.find(params[:id])
  end

  # POST /menu_labels
  # POST /menu_labels.xml
  def create
    @menu_label = MenuLabel.new(params[:menu_label])

    respond_to do |format|
      if @menu_label.save
        format.html { redirect_to(@menu_label, :notice => 'Menu label was successfully created.') }
        format.xml  { render :xml => @menu_label, :status => :created, :location => @menu_label }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @menu_label.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /menu_labels/1
  # PUT /menu_labels/1.xml
  def update
    @menu_label = MenuLabel.find(params[:id])

    respond_to do |format|
      if @menu_label.update_attributes(params[:menu_label])
        format.html { redirect_to(@menu_label, :notice => 'Menu label was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menu_label.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_labels/1
  # DELETE /menu_labels/1.xml
  def destroy
    @menu_label = MenuLabel.find(params[:id])
    @menu_label.destroy

    respond_to do |format|
      format.html { redirect_to(menu_labels_url) }
      format.xml  { head :ok }
    end
  end
end
