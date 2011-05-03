require "spec_helper"

describe MenuItemRatingsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/menu_item_ratings" }.should route_to(:controller => "menu_item_ratings", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/menu_item_ratings/new" }.should route_to(:controller => "menu_item_ratings", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/menu_item_ratings/1" }.should route_to(:controller => "menu_item_ratings", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/menu_item_ratings/1/edit" }.should route_to(:controller => "menu_item_ratings", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/menu_item_ratings" }.should route_to(:controller => "menu_item_ratings", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/menu_item_ratings/1" }.should route_to(:controller => "menu_item_ratings", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/menu_item_ratings/1" }.should route_to(:controller => "menu_item_ratings", :action => "destroy", :id => "1")
    end

  end
end
