require 'spec_helper'

describe "FoursquareCheckins" do
  describe "GET /foursquare_checkins" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get foursquare_checkins_path
      response.status.should be(200)
    end
  end
end
