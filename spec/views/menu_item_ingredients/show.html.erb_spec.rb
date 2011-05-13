require 'spec_helper'

describe "menu_item_ingredients/show.html.haml" do
  before(:each) do
    @menu_item_ingredient = assign(:menu_item_ingredient, stub_model(MenuItemIngredient,
      :menu_item_id => 1,
      :ingredient_id => 1,
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
