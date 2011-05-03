require 'spec_helper'

describe "MenuItemIngredients" do
  describe "GET /menu_item_ingredients" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get menu_item_ingredients_path
      response.status.should be(200)
    end
  end
end
