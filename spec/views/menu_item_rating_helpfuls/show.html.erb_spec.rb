require 'spec_helper'

describe "menu_item_rating_helpfuls/show.html.haml" do
  before(:each) do
    @menu_item_rating_helpful = assign(:menu_item_rating_helpful, stub_model(MenuItemRatingHelpful,
      :menu_item_rating_id => 1,
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
