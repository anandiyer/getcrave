require "spec_helper"

describe RestaurantLabelAssociationsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/restaurant_label_associations" }.should route_to(:controller => "restaurant_label_associations", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/restaurant_label_associations/new" }.should route_to(:controller => "restaurant_label_associations", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/restaurant_label_associations/1" }.should route_to(:controller => "restaurant_label_associations", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/restaurant_label_associations/1/edit" }.should route_to(:controller => "restaurant_label_associations", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/restaurant_label_associations" }.should route_to(:controller => "restaurant_label_associations", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/restaurant_label_associations/1" }.should route_to(:controller => "restaurant_label_associations", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/restaurant_label_associations/1" }.should route_to(:controller => "restaurant_label_associations", :action => "destroy", :id => "1")
    end

  end
end
