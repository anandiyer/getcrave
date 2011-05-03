require 'spec_helper'

describe "menu_item_review_comments/new.html.erb" do
  before(:each) do
    assign(:menu_item_review_comment, stub_model(MenuItemReviewComment,
      :menu_item_rating_id => 1,
      :user_id => 1,
      :comment => "MyString"
    ).as_new_record)
  end

  it "renders new menu_item_review_comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => menu_item_review_comments_path, :method => "post" do
      assert_select "input#menu_item_review_comment_menu_item_rating_id", :name => "menu_item_review_comment[menu_item_rating_id]"
      assert_select "input#menu_item_review_comment_user_id", :name => "menu_item_review_comment[user_id]"
      assert_select "input#menu_item_review_comment_comment", :name => "menu_item_review_comment[comment]"
    end
  end
end
