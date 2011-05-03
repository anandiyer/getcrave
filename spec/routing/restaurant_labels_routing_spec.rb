require "spec_helper"

describe RestaurantLabelsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/restaurant_labels" }.should route_to(:controller => "restaurant_labels", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/restaurant_labels/new" }.should route_to(:controller => "restaurant_labels", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/restaurant_labels/1" }.should route_to(:controller => "restaurant_labels", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/restaurant_labels/1/edit" }.should route_to(:controller => "restaurant_labels", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/restaurant_labels" }.should route_to(:controller => "restaurant_labels", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/restaurant_labels/1" }.should route_to(:controller => "restaurant_labels", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/restaurant_labels/1" }.should route_to(:controller => "restaurant_labels", :action => "destroy", :id => "1")
    end

  end
end
