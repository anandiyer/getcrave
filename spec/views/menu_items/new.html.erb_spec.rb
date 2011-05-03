require 'spec_helper'

describe "menu_items/new.html.erb" do
  before(:each) do
    assign(:menu_item, stub_model(MenuItem,
      :restaurant_id => 1,
      :name => "MyString",
      :description => "MyString",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new menu_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => menu_items_path, :method => "post" do
      assert_select "input#menu_item_restaurant_id", :name => "menu_item[restaurant_id]"
      assert_select "input#menu_item_name", :name => "menu_item[name]"
      assert_select "input#menu_item_description", :name => "menu_item[description]"
      assert_select "input#menu_item_user_id", :name => "menu_item[user_id]"
    end
  end
end
