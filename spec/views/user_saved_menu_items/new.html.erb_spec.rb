require 'spec_helper'

describe "user_saved_menu_items/new.html.erb" do
  before(:each) do
    assign(:user_saved_menu_item, stub_model(UserSavedMenuItem,
      :user_id => 1,
      :menu_item_id => 1
    ).as_new_record)
  end

  it "renders new user_saved_menu_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_saved_menu_items_path, :method => "post" do
      assert_select "input#user_saved_menu_item_user_id", :name => "user_saved_menu_item[user_id]"
      assert_select "input#user_saved_menu_item_menu_item_id", :name => "user_saved_menu_item[menu_item_id]"
    end
  end
end
