require "spec_helper"

describe MenuItemIngredientsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/menu_item_ingredients" }.should route_to(:controller => "menu_item_ingredients", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/menu_item_ingredients/new" }.should route_to(:controller => "menu_item_ingredients", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/menu_item_ingredients/1" }.should route_to(:controller => "menu_item_ingredients", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/menu_item_ingredients/1/edit" }.should route_to(:controller => "menu_item_ingredients", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/menu_item_ingredients" }.should route_to(:controller => "menu_item_ingredients", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/menu_item_ingredients/1" }.should route_to(:controller => "menu_item_ingredients", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/menu_item_ingredients/1" }.should route_to(:controller => "menu_item_ingredients", :action => "destroy", :id => "1")
    end

  end
end
