require 'spec_helper'

describe "menu_item_prices/edit.html.erb" do
  before(:each) do
    @menu_item_price = assign(:menu_item_price, stub_model(MenuItemPrice,
      :menu_item_id => 1,
      :price_for => "MyString",
      :price => "",
      :user_id => 1
    ))
  end

  it "renders the edit menu_item_price form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => menu_item_prices_path(@menu_item_price), :method => "post" do
      assert_select "input#menu_item_price_menu_item_id", :name => "menu_item_price[menu_item_id]"
      assert_select "input#menu_item_price_price_for", :name => "menu_item_price[price_for]"
      assert_select "input#menu_item_price_price", :name => "menu_item_price[price]"
      assert_select "input#menu_item_price_user_id", :name => "menu_item_price[user_id]"
    end
  end
end
