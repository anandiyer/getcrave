require "spec_helper"

describe RestaurantCuisinesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/restaurant_cuisines" }.should route_to(:controller => "restaurant_cuisines", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/restaurant_cuisines/new" }.should route_to(:controller => "restaurant_cuisines", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/restaurant_cuisines/1" }.should route_to(:controller => "restaurant_cuisines", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/restaurant_cuisines/1/edit" }.should route_to(:controller => "restaurant_cuisines", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/restaurant_cuisines" }.should route_to(:controller => "restaurant_cuisines", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/restaurant_cuisines/1" }.should route_to(:controller => "restaurant_cuisines", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/restaurant_cuisines/1" }.should route_to(:controller => "restaurant_cuisines", :action => "destroy", :id => "1")
    end

  end
end
