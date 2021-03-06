require 'spec_helper'

describe "restaurant_label_associations/index.html.erb" do
  before(:each) do
    assign(:restaurant_label_associations, [
      stub_model(RestaurantLabelAssociation,
        :restaurant_id => 1,
        :restaurant_label_id => 1,
        :user_id => 1
      ),
      stub_model(RestaurantLabelAssociation,
        :restaurant_id => 1,
        :restaurant_label_id => 1,
        :user_id => 1
      )
    ])
  end

  it "renders a list of restaurant_label_associations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
