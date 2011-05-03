require 'spec_helper'

describe "RestaurantCuisines" do
  describe "GET /restaurant_cuisines" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get restaurant_cuisines_path
      response.status.should be(200)
    end
  end
end
