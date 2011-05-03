require 'spec_helper'

describe "restaurant_cuisine_associations/show.html.erb" do
  before(:each) do
    @restaurant_cuisine_association = assign(:restaurant_cuisine_association, stub_model(RestaurantCuisineAssociation,
      :restaurant_id => 1,
      :restaurant_cuisine_id => 1
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
