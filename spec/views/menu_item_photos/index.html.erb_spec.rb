require 'spec_helper'

describe "menu_item_photos/index.html.haml" do
  before(:each) do
    assign(:menu_item_photos, [
      stub_model(MenuItemPhoto,
        :menu_item_id => 1,
        :photo => "Photo",
        :user_id => 1
      ),
      stub_model(MenuItemPhoto,
        :menu_item_id => 1,
        :photo => "Photo",
        :user_id => 1
      )
    ])
  end

  it "renders a list of menu_item_photos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Photo".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
