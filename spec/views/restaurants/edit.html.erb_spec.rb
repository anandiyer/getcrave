require 'spec_helper'

describe "restaurants/edit.html.erb" do
  before(:each) do
    @restaurant = assign(:restaurant, stub_model(Restaurant,
      :name => "MyString",
      :latitude_longitude => "",
      :street_address => "MyString",
      :neighborhood => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => "MyString",
      :country => "MyString",
      :cross_street => "MyString"
    ))
  end

  it "renders the edit restaurant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => restaurants_path(@restaurant), :method => "post" do
      assert_select "input#restaurant_name", :name => "restaurant[name]"
      assert_select "input#restaurant_latidude_longitude", :name => "restaurant[latidude_longitude]"
      assert_select "input#restaurant_street_address", :name => "restaurant[street_address]"
      assert_select "input#restaurant_neighborhood", :name => "restaurant[neighborhood]"
      assert_select "input#restaurant_city", :name => "restaurant[city]"
      assert_select "input#restaurant_state", :name => "restaurant[state]"
      assert_select "input#restaurant_zip", :name => "restaurant[zip]"
      assert_select "input#restaurant_country", :name => "restaurant[country]"
      assert_select "input#restaurant_cross_street", :name => "restaurant[cross_street]"
    end
  end
end
