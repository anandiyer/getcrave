require 'spec_helper'

describe "restaurant_labels/index.html.erb" do
  before(:each) do
    assign(:restaurant_labels, [
      stub_model(RestaurantLabel,
        :restaurant_label => "Restaurant Label"
      ),
      stub_model(RestaurantLabel,
        :restaurant_label => "Restaurant Label"
      )
    ])
  end

  it "renders a list of restaurant_labels" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Restaurant Label".to_s, :count => 2
  end
end
