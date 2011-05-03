require 'spec_helper'

describe "menu_item_photos/new.html.erb" do
  before(:each) do
    assign(:menu_item_photo, stub_model(MenuItemPhoto,
      :menu_item_id => 1,
      :photo => "MyString",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new menu_item_photo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => menu_item_photos_path, :method => "post" do
      assert_select "input#menu_item_photo_menu_item_id", :name => "menu_item_photo[menu_item_id]"
      assert_select "input#menu_item_photo_photo", :name => "menu_item_photo[photo]"
      assert_select "input#menu_item_photo_user_id", :name => "menu_item_photo[user_id]"
    end
  end
end
