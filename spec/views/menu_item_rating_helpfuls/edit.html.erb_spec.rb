require 'spec_helper'

describe "menu_item_rating_helpfuls/edit.html.erb" do
  before(:each) do
    @menu_item_rating_helpful = assign(:menu_item_rating_helpful, stub_model(MenuItemRatingHelpful,
      :menu_item_rating_id => 1,
      :user_id => 1
    ))
  end

  it "renders the edit menu_item_rating_helpful form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => menu_item_rating_helpfuls_path(@menu_item_rating_helpful), :method => "post" do
      assert_select "input#menu_item_rating_helpful_menu_item_rating_id", :name => "menu_item_rating_helpful[menu_item_rating_id]"
      assert_select "input#menu_item_rating_helpful_user_id", :name => "menu_item_rating_helpful[user_id]"
    end
  end
end
