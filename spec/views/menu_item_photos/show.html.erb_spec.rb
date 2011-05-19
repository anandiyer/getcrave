require 'spec_helper'

describe "menu_item_photos/_unused_show.html.haml" do
  before(:each) do
    @menu_item_photo = assign(:menu_item_photo, stub_model(MenuItemPhoto,
      :menu_item_id => 1,
      :photo => "Photo",
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Photo/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
