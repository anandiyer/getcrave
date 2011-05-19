require 'spec_helper'

describe "user_saved_menu_items/index.html.haml" do
  before(:each) do
    assign(:user_saved_menu_items, [
      stub_model(UserSavedMenuItem,
        :user_id => 1,
        :menu_item_id => 1
      ),
      stub_model(UserSavedMenuItem,
        :user_id => 1,
        :menu_item_id => 1
      )
    ])
  end

  it "renders a list of user_saved_menu_items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
