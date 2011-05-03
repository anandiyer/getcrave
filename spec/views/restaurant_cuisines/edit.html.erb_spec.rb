require 'spec_helper'

describe "restaurant_cuisines/edit.html.erb" do
  before(:each) do
    @restaurant_cuisine = assign(:restaurant_cuisine, stub_model(RestaurantCuisine,
      :restaurant_cuisine => "MyString"
    ))
  end

  it "renders the edit restaurant_cuisine form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => restaurant_cuisines_path(@restaurant_cuisine), :method => "post" do
      assert_select "input#restaurant_cuisine_restaurant_cuisine", :name => "restaurant_cuisine[restaurant_cuisine]"
    end
  end
end
