require 'spec_helper'

describe "menu_item_review_comments/show.html.erb" do
  before(:each) do
    @menu_item_review_comment = assign(:menu_item_review_comment, stub_model(MenuItemReviewComment,
      :menu_item_rating_id => 1,
      :user_id => 1,
      :comment => "Comment"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Comment/)
  end
end
