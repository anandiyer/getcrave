require 'spec_helper'

describe "restaurant_labels/edit.html.erb" do
  before(:each) do
    @restaurant_label = assign(:restaurant_label, stub_model(RestaurantLabel,
      :restaurant_label => "MyString"
    ))
  end

  it "renders the edit restaurant_label form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => restaurant_labels_path(@restaurant_label), :method => "post" do
      assert_select "input#restaurant_label_restaurant_label", :name => "restaurant_label[restaurant_label]"
    end
  end
end
