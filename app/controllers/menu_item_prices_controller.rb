class MenuItemPricesController < ApplicationController
  # GET /menu_item_prices
  # GET /menu_item_prices.xml
  def index
    @menu_item_prices = MenuItemPrice.all

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @menu_item_prices }
    end
  end

  # GET /menu_item_prices/1
  # GET /menu_item_prices/1.xml
  def show
    @menu_item_price = MenuItemPrice.find(params[:id])

    respond_to do |format|
      format.html # _unused_show.html.haml
      format.xml  { render :xml => @menu_item_price }
    end
  end

  # GET /menu_item_prices/new
  # GET /menu_item_prices/new.xml
  def new
    @menu_item_price = MenuItemPrice.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @menu_item_price }
    end
  end

  # GET /menu_item_prices/1/edit
  def edit
    @menu_item_price = MenuItemPrice.find(params[:id])
  end

  # POST /menu_item_prices
  # POST /menu_item_prices.xml
  def create
    @menu_item_price = MenuItemPrice.new(params[:menu_item_price])

    respond_to do |format|
      if @menu_item_price.save
        format.html { redirect_to(@menu_item_price, :notice => 'Menu item price was successfully created.') }
        format.xml  { render :xml => @menu_item_price, :status => :created, :location => @menu_item_price }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @menu_item_price.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /menu_item_prices/1
  # PUT /menu_item_prices/1.xml
  def update
    @menu_item_price = MenuItemPrice.find(params[:id])

    respond_to do |format|
      if @menu_item_price.update_attributes(params[:menu_item_price])
        format.html { redirect_to(@menu_item_price, :notice => 'Menu item price was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menu_item_price.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_item_prices/1
  # DELETE /menu_item_prices/1.xml
  def destroy
    @menu_item_price = MenuItemPrice.find(params[:id])
    @menu_item_price.destroy

    respond_to do |format|
      format.html { redirect_to(menu_item_prices_url) }
      format.xml  { head :ok }
    end
  end
end
