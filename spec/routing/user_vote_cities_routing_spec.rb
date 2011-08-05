require "spec_helper"

describe UserVoteCitiesController do
  describe "routing" do

    it "routes to #index" do
      get("/user_vote_cities").should route_to("user_vote_cities#index")
    end

    it "routes to #new" do
      get("/user_vote_cities/new").should route_to("user_vote_cities#new")
    end

    it "routes to #show" do
      get("/user_vote_cities/1").should route_to("user_vote_cities#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_vote_cities/1/edit").should route_to("user_vote_cities#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_vote_cities").should route_to("user_vote_cities#create")
    end

    it "routes to #update" do
      put("/user_vote_cities/1").should route_to("user_vote_cities#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_vote_cities/1").should route_to("user_vote_cities#destroy", :id => "1")
    end

  end
end
