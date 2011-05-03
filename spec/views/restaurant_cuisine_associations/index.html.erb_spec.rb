require 'spec_helper'

describe "restaurant_cuisine_associations/index.html.erb" do
  before(:each) do
    assign(:restaurant_cuisine_associations, [
      stub_model(RestaurantCuisineAssociation,
        :restaurant_id => 1,
        :restaurant_cuisine_id => 1
      ),
      stub_model(RestaurantCuisineAssociation,
        :restaurant_id => 1,
        :restaurant_cuisine_id => 1
      )
    ])
  end

  it "renders a list of restaurant_cuisine_associations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
