require 'spec_helper'

describe "MenuLabels" do
  describe "GET /menu_labels" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get menu_labels_path
      response.status.should be(200)
    end
  end
end
