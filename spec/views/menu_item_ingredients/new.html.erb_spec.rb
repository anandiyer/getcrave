require 'spec_helper'

describe "menu_item_ingredients/new.html.erb" do
  before(:each) do
    assign(:menu_item_ingredient, stub_model(MenuItemIngredient,
      :menu_item_id => 1,
      :ingredient_id => 1,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new menu_item_ingredient form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => menu_item_ingredients_path, :method => "post" do
      assert_select "input#menu_item_ingredient_menu_item_id", :name => "menu_item_ingredient[menu_item_id]"
      assert_select "input#menu_item_ingredient_ingredient_id", :name => "menu_item_ingredient[ingredient_id]"
      assert_select "input#menu_item_ingredient_user_id", :name => "menu_item_ingredient[user_id]"
    end
  end
end
