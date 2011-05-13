class MenuItemIngredientsController < ApplicationController
  # GET /menu_item_ingredients
  # GET /menu_item_ingredients.xml
  def index
    @menu_item_ingredients = MenuItemIngredient.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @menu_item_ingredients }
    end
  end

  # GET /menu_item_ingredients/1
  # GET /menu_item_ingredients/1.xml
  def show
    @menu_item_ingredient = MenuItemIngredient.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @menu_item_ingredient }
    end
  end

  # GET /menu_item_ingredients/new
  # GET /menu_item_ingredients/new.xml
  def new
    @menu_item_ingredient = MenuItemIngredient.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @menu_item_ingredient }
    end
  end

  # GET /menu_item_ingredients/1/edit
  def edit
    @menu_item_ingredient = MenuItemIngredient.find(params[:id])
  end

  # POST /menu_item_ingredients
  # POST /menu_item_ingredients.xml
  def create
    @menu_item_ingredient = MenuItemIngredient.new(params[:menu_item_ingredient])

    respond_to do |format|
      if @menu_item_ingredient.save
        format.html { redirect_to(@menu_item_ingredient, :notice => 'Menu item ingredient was successfully created.') }
        format.xml  { render :xml => @menu_item_ingredient, :status => :created, :location => @menu_item_ingredient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @menu_item_ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /menu_item_ingredients/1
  # PUT /menu_item_ingredients/1.xml
  def update
    @menu_item_ingredient = MenuItemIngredient.find(params[:id])

    respond_to do |format|
      if @menu_item_ingredient.update_attributes(params[:menu_item_ingredient])
        format.html { redirect_to(@menu_item_ingredient, :notice => 'Menu item ingredient was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menu_item_ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_item_ingredients/1
  # DELETE /menu_item_ingredients/1.xml
  def destroy
    @menu_item_ingredient = MenuItemIngredient.find(params[:id])
    @menu_item_ingredient.destroy

    respond_to do |format|
      format.html { redirect_to(menu_item_ingredients_url) }
      format.xml  { head :ok }
    end
  end
end
