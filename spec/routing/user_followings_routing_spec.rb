require "spec_helper"

describe UserFollowingsController do
  describe "routing" do

    it "routes to #index" do
      get("/user_followings").should route_to("user_followings#index")
    end

    it "routes to #new" do
      get("/user_followings/new").should route_to("user_followings#new")
    end

    it "routes to #show" do
      get("/user_followings/1").should route_to("user_followings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_followings/1/edit").should route_to("user_followings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_followings").should route_to("user_followings#create")
    end

    it "routes to #update" do
      put("/user_followings/1").should route_to("user_followings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_followings/1").should route_to("user_followings#destroy", :id => "1")
    end

  end
end
