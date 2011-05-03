require "spec_helper"

describe MenuItemPricesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/menu_item_prices" }.should route_to(:controller => "menu_item_prices", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/menu_item_prices/new" }.should route_to(:controller => "menu_item_prices", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/menu_item_prices/1" }.should route_to(:controller => "menu_item_prices", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/menu_item_prices/1/edit" }.should route_to(:controller => "menu_item_prices", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/menu_item_prices" }.should route_to(:controller => "menu_item_prices", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/menu_item_prices/1" }.should route_to(:controller => "menu_item_prices", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/menu_item_prices/1" }.should route_to(:controller => "menu_item_prices", :action => "destroy", :id => "1")
    end

  end
end
