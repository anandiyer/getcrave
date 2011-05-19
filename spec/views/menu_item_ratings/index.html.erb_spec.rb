require 'spec_helper'

describe "menu_item_ratings/index.html.haml" do
  before(:each) do
    assign(:menu_item_ratings, [
      stub_model(MenuItemRating,
        :menu_item_id => 1,
        :user_id => 1,
        :rating => 1,
        :review => "Review"
      ),
      stub_model(MenuItemRating,
        :menu_item_id => 1,
        :user_id => 1,
        :rating => 1,
        :review => "Review"
      )
    ])
  end

  it "renders a list of menu_item_ratings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Review".to_s, :count => 2
  end
end
