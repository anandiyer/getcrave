require 'spec_helper'

describe "RestaurantCuisineAssociations" do
  describe "GET /restaurant_cuisine_associations" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get restaurant_cuisine_associations_path
      response.status.should be(200)
    end
  end
end
