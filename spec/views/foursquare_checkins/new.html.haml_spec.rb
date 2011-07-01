require 'spec_helper'

describe "foursquare_checkins/new.html.haml" do
  before(:each) do
    assign(:foursquare_checkin, stub_model(FoursquareCheckin,
      :venue_id => "MyString",
      :user_id => 1,
      :checkin_id => "MyString"
    ).as_new_record)
  end

  it "renders new foursquare_checkin form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => foursquare_checkins_path, :method => "post" do
      assert_select "input#foursquare_checkin_venue_id", :name => "foursquare_checkin[venue_id]"
      assert_select "input#foursquare_checkin_user_id", :name => "foursquare_checkin[user_id]"
      assert_select "input#foursquare_checkin_checkin_id", :name => "foursquare_checkin[checkin_id]"
    end
  end
end
