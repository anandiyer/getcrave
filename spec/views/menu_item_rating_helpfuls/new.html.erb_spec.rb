require 'spec_helper'

describe "menu_item_rating_helpfuls/new.html.erb" do
  before(:each) do
    assign(:menu_item_rating_helpful, stub_model(MenuItemRatingHelpful,
      :menu_item_rating_id => 1,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new menu_item_rating_helpful form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => menu_item_rating_helpfuls_path, :method => "post" do
      assert_select "input#menu_item_rating_helpful_menu_item_rating_id", :name => "menu_item_rating_helpful[menu_item_rating_id]"
      assert_select "input#menu_item_rating_helpful_user_id", :name => "menu_item_rating_helpful[user_id]"
    end
  end
end
