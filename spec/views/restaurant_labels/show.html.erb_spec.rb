require 'spec_helper'

describe "restaurant_labels/show.html.erb" do
  before(:each) do
    @restaurant_label = assign(:restaurant_label, stub_model(RestaurantLabel,
      :restaurant_label => "Restaurant Label"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Restaurant Label/)
  end
end
