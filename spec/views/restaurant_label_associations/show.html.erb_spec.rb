require 'spec_helper'

describe "restaurant_label_associations/_unused_show.html.haml" do
  before(:each) do
    @restaurant_label_association = assign(:restaurant_label_association, stub_model(RestaurantLabelAssociation,
      :restaurant_id => 1,
      :restaurant_label_id => 1,
      :user_id => 1
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
  end
end
