require 'spec_helper'

describe "restaurant_cuisine_associations/new.html.erb" do
  before(:each) do
    assign(:restaurant_cuisine_association, stub_model(RestaurantCuisineAssociation,
      :restaurant_id => 1,
      :restaurant_cuisine_id => 1
    ).as_new_record)
  end

  it "renders new restaurant_cuisine_association form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => restaurant_cuisine_associations_path, :method => "post" do
      assert_select "input#restaurant_cuisine_association_restaurant_id", :name => "restaurant_cuisine_association[restaurant_id]"
      assert_select "input#restaurant_cuisine_association_restaurant_cuisine_id", :name => "restaurant_cuisine_association[restaurant_cuisine_id]"
    end
  end
end
