require "spec_helper"

describe MenuItemRatingHelpfulsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/menu_item_rating_helpfuls" }.should route_to(:controller => "menu_item_rating_helpfuls", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/menu_item_rating_helpfuls/new" }.should route_to(:controller => "menu_item_rating_helpfuls", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/menu_item_rating_helpfuls/1" }.should route_to(:controller => "menu_item_rating_helpfuls", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/menu_item_rating_helpfuls/1/edit" }.should route_to(:controller => "menu_item_rating_helpfuls", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/menu_item_rating_helpfuls" }.should route_to(:controller => "menu_item_rating_helpfuls", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/menu_item_rating_helpfuls/1" }.should route_to(:controller => "menu_item_rating_helpfuls", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/menu_item_rating_helpfuls/1" }.should route_to(:controller => "menu_item_rating_helpfuls", :action => "destroy", :id => "1")
    end

  end
end
