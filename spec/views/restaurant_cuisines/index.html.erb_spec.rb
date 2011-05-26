require 'spec_helper'

describe "restaurant_cuisines/index.html.erb" do
  before(:each) do
    assign(:restaurant_cuisines, [
      stub_model(RestaurantCuisine,
        :restaurant_cuisine => "Restaurant Cuisine"
      ),
      stub_model(RestaurantCuisine,
        :restaurant_cuisine => "Restaurant Cuisine"
      )
    ])
  end

  it "renders a list of restaurant_cuisines" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Restaurant Cuisine".to_s, :count => 2
  end
end
