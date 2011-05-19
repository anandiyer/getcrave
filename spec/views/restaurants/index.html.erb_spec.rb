require 'spec_helper'

describe "restaurants/index.html.haml" do
  before(:each) do
    assign(:restaurants, [
      stub_model(Restaurant,
        :name => "Name",
        :latitude_longitude => "",
        :street_address => "Street Address",
        :neighborhood => "Neighborhood",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :country => "Country",
        :cross_street => "Cross Street"
      ),
      stub_model(Restaurant,
        :name => "Name",
        :latitude_longitude => "",
        :street_address => "Street Address",
        :neighborhood => "Neighborhood",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :country => "Country",
        :cross_street => "Cross Street"
      )
    ])
  end

  it "renders a list of restaurants" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Street Address".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Neighborhood".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "State".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Cross Street".to_s, :count => 2
  end
end
