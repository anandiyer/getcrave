require 'spec_helper'

describe "menu_item_prices/show.html.haml" do
  before(:each) do
    @menu_item_price = assign(:menu_item_price, stub_model(MenuItemPrice,
      :menu_item_id => 1,
      :price_for => "Price For",
      :price => "",
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Price For/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
