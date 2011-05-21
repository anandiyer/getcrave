require 'spec_helper'

describe "menu_item_rating_helpfuls/index.html.haml" do
  before(:each) do
    assign(:menu_item_rating_helpfuls, [
      stub_model(MenuItemRatingHelpful,
        :menu_item_rating_id => 1,
        :user_id => 1
      ),
      stub_model(MenuItemRatingHelpful,
        :menu_item_rating_id => 1,
        :user_id => 1
      )
    ])
  end

  it "renders a list of menu_item_rating_helpfuls" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
