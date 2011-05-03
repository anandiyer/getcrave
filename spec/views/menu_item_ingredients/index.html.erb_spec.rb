require 'spec_helper'

describe "menu_item_ingredients/index.html.erb" do
  before(:each) do
    assign(:menu_item_ingredients, [
      stub_model(MenuItemIngredient,
        :menu_item_id => 1,
        :ingredient_id => 1,
        :user_id => 1
      ),
      stub_model(MenuItemIngredient,
        :menu_item_id => 1,
        :ingredient_id => 1,
        :user_id => 1
      )
    ])
  end

  it "renders a list of menu_item_ingredients" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
