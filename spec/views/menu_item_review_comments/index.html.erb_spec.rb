require 'spec_helper'

describe "menu_item_review_comments/index.html.erb" do
  before(:each) do
    assign(:menu_item_review_comments, [
      stub_model(MenuItemReviewComment,
        :menu_item_rating_id => 1,
        :user_id => 1,
        :comment => "Comment"
      ),
      stub_model(MenuItemReviewComment,
        :menu_item_rating_id => 1,
        :user_id => 1,
        :comment => "Comment"
      )
    ])
  end

  it "renders a list of menu_item_review_comments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
  end
end
