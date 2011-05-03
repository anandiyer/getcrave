require 'spec_helper'

describe "restaurant_label_associations/new.html.erb" do
  before(:each) do
    assign(:restaurant_label_association, stub_model(RestaurantLabelAssociation,
      :restaurant_id => 1,
      :restaurant_label_id => 1,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new restaurant_label_association form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => restaurant_label_associations_path, :method => "post" do
      assert_select "input#restaurant_label_association_restaurant_id", :name => "restaurant_label_association[restaurant_id]"
      assert_select "input#restaurant_label_association_restaurant_label_id", :name => "restaurant_label_association[restaurant_label_id]"
      assert_select "input#restaurant_label_association_user_id", :name => "restaurant_label_association[user_id]"
    end
  end
end
