require 'spec_helper'

describe "menu_item_review_comments/edit.html.erb" do
  before(:each) do
    @menu_item_review_comment = assign(:menu_item_review_comment, stub_model(MenuItemReviewComment,
      :menu_item_rating_id => 1,
      :user_id => 1,
      :comment => "MyString"
    ))
  end

  it "renders the edit menu_item_review_comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => menu_item_review_comments_path(@menu_item_review_comment), :method => "post" do
      assert_select "input#menu_item_review_comment_menu_item_rating_id", :name => "menu_item_review_comment[menu_item_rating_id]"
      assert_select "input#menu_item_review_comment_user_id", :name => "menu_item_review_comment[user_id]"
      assert_select "input#menu_item_review_comment_comment", :name => "menu_item_review_comment[comment]"
    end
  end
end
