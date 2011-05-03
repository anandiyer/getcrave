require 'spec_helper'

describe "menu_item_ratings/new.html.erb" do
  before(:each) do
    assign(:menu_item_rating, stub_model(MenuItemRating,
      :menu_item_id => 1,
      :user_id => 1,
      :rating => 1,
      :review => "MyString"
    ).as_new_record)
  end

  it "renders new menu_item_rating form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => menu_item_ratings_path, :method => "post" do
      assert_select "input#menu_item_rating_menu_item_id", :name => "menu_item_rating[menu_item_id]"
      assert_select "input#menu_item_rating_user_id", :name => "menu_item_rating[user_id]"
      assert_select "input#menu_item_rating_rating", :name => "menu_item_rating[rating]"
      assert_select "input#menu_item_rating_review", :name => "menu_item_rating[review]"
    end
  end
end
