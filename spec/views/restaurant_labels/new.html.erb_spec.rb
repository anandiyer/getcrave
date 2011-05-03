require 'spec_helper'

describe "restaurant_labels/new.html.erb" do
  before(:each) do
    assign(:restaurant_label, stub_model(RestaurantLabel,
      :restaurant_label => "MyString"
    ).as_new_record)
  end

  it "renders new restaurant_label form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => restaurant_labels_path, :method => "post" do
      assert_select "input#restaurant_label_restaurant_label", :name => "restaurant_label[restaurant_label]"
    end
  end
end
