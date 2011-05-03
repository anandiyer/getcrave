require "spec_helper"

describe MenuLabelsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/menu_labels" }.should route_to(:controller => "menu_labels", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/menu_labels/new" }.should route_to(:controller => "menu_labels", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/menu_labels/1" }.should route_to(:controller => "menu_labels", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/menu_labels/1/edit" }.should route_to(:controller => "menu_labels", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/menu_labels" }.should route_to(:controller => "menu_labels", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/menu_labels/1" }.should route_to(:controller => "menu_labels", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/menu_labels/1" }.should route_to(:controller => "menu_labels", :action => "destroy", :id => "1")
    end

  end
end
