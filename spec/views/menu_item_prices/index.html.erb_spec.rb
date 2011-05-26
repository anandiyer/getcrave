require 'spec_helper'

describe "menu_item_prices/index.html.erb" do
  before(:each) do
    assign(:menu_item_prices, [
      stub_model(MenuItemPrice,
        :menu_item_id => 1,
        :price_for => "Price For",
        :price => "",
        :user_id => 1
      ),
      stub_model(MenuItemPrice,
        :menu_item_id => 1,
        :price_for => "Price For",
        :price => "",
        :user_id => 1
      )
    ])
  end

  it "renders a list of menu_item_prices" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Price For".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
