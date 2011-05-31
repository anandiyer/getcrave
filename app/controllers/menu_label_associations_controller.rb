class MenuLabelAssociationsController < ApplicationController
  # GET /menu_label_associations
  # GET /menu_label_associations.xml
  def index
    @menu_label_associations = MenuLabelAssociation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @menu_label_associations }
    end
  end

  # GET /menu_label_associations/1
  # GET /menu_label_associations/1.xml
  def show
    @menu_label_association = MenuLabelAssociation.find(params[:id])

    respond_to do |format|
      format.html # _unused_show.html.haml
      format.xml  { render :xml => @menu_label_association }
    end
  end

  # GET /menu_label_associations/new
  # GET /menu_label_associations/new.xml
  def new
    @menu_label_association = MenuLabelAssociation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @menu_label_association }
    end
  end

  # GET /menu_label_associations/1/edit
  def edit
    @menu_label_association = MenuLabelAssociation.find(params[:id])
  end


  # POST /menu_label_associations
  # POST /menu_label_associations.xml
  def create

#    @menu_label_association2 = MenuLabelAssociation.where(:user_id => params[:menu_label_association][:user_id], :menu_item_id => params[:menu_label_association][:menu_item_id]).any?

    any_exist = MenuLabelAssociation.where(params[:menu_label_association]).any?

    respond_to do |format|
      if !any_exist
        @menu_label_association = MenuLabelAssociation.new(params[:menu_label_association])


        if @menu_label_association.save
          format.html { redirect_to(@menu_label_association, :notice => 'Menu label association was successfully created.') }
          format.xml { render :xml => @menu_label_association, :status => :created, :location => @menu_label_association }
          format.js { render :partial => "menu_items/labels_list" }
        end
      else
        format.js { render :js => "window.g_notice('Warning!','You added this label before!')" }
      end
    end
  end

  # PUT /menu_label_associations/1
  # PUT /menu_label_associations/1.xml
  def update
    @menu_label_association = MenuLabelAssociation.find(params[:id])

    respond_to do |format|
      if @menu_label_association.update_attributes(params[:menu_label_association])
        format.html { redirect_to(@menu_label_association, :notice => 'Menu label association was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menu_label_association.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_label_associations/1
  # DELETE /menu_label_associations/1.xml
  def destroy
    @menu_label_association = MenuLabelAssociation.find(params[:id])
    @menu_label_association.destroy

    respond_to do |format|
      format.html { redirect_to(menu_label_associations_url) }
      format.xml  { head :ok }
    end
  end
end
