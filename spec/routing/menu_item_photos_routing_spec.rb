require "spec_helper"

describe MenuItemPhotosController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/menu_item_photos" }.should route_to(:controller => "menu_item_photos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/menu_item_photos/new" }.should route_to(:controller => "menu_item_photos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/menu_item_photos/1" }.should route_to(:controller => "menu_item_photos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/menu_item_photos/1/edit" }.should route_to(:controller => "menu_item_photos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/menu_item_photos" }.should route_to(:controller => "menu_item_photos", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/menu_item_photos/1" }.should route_to(:controller => "menu_item_photos", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/menu_item_photos/1" }.should route_to(:controller => "menu_item_photos", :action => "destroy", :id => "1")
    end

  end
end
