require 'spec_helper'

describe "menu_item_ratings/show.html.haml" do
  before(:each) do
    @menu_item_rating = assign(:menu_item_rating, stub_model(MenuItemRating,
      :menu_item_id => 1,
      :user_id => 1,
      :rating => 1,
      :review => "Review"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Review/)
  end
end
