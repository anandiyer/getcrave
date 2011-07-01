require "spec_helper"

describe FoursquareCheckinsController do
  describe "routing" do

    it "routes to #index" do
      get("/foursquare_checkins").should route_to("foursquare_checkins#index")
    end

    it "routes to #new" do
      get("/foursquare_checkins/new").should route_to("foursquare_checkins#new")
    end

    it "routes to #show" do
      get("/foursquare_checkins/1").should route_to("foursquare_checkins#show", :id => "1")
    end

    it "routes to #edit" do
      get("/foursquare_checkins/1/edit").should route_to("foursquare_checkins#edit", :id => "1")
    end

    it "routes to #create" do
      post("/foursquare_checkins").should route_to("foursquare_checkins#create")
    end

    it "routes to #update" do
      put("/foursquare_checkins/1").should route_to("foursquare_checkins#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/foursquare_checkins/1").should route_to("foursquare_checkins#destroy", :id => "1")
    end

  end
end
