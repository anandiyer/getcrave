require "spec_helper"

describe MenuItemReviewCommentsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/menu_item_review_comments" }.should route_to(:controller => "menu_item_review_comments", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/menu_item_review_comments/new" }.should route_to(:controller => "menu_item_review_comments", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/menu_item_review_comments/1" }.should route_to(:controller => "menu_item_review_comments", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/menu_item_review_comments/1/edit" }.should route_to(:controller => "menu_item_review_comments", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/menu_item_review_comments" }.should route_to(:controller => "menu_item_review_comments", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/menu_item_review_comments/1" }.should route_to(:controller => "menu_item_review_comments", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/menu_item_review_comments/1" }.should route_to(:controller => "menu_item_review_comments", :action => "destroy", :id => "1")
    end

  end
end
