require 'spec_helper'

describe "restaurant_cuisines/show.html.haml" do
  before(:each) do
    @restaurant_cuisine = assign(:restaurant_cuisine, stub_model(RestaurantCuisine,
      :restaurant_cuisine => "Restaurant Cuisine"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Restaurant Cuisine/)
  end
end
