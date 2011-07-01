require 'spec_helper'

describe "foursquare_checkins/edit.html.haml" do
  before(:each) do
    @foursquare_checkin = assign(:foursquare_checkin, stub_model(FoursquareCheckin,
      :venue_id => "MyString",
      :user_id => 1,
      :checkin_id => "MyString"
    ))
  end

  it "renders the edit foursquare_checkin form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => foursquare_checkins_path(@foursquare_checkin), :method => "post" do
      assert_select "input#foursquare_checkin_venue_id", :name => "foursquare_checkin[venue_id]"
      assert_select "input#foursquare_checkin_user_id", :name => "foursquare_checkin[user_id]"
      assert_select "input#foursquare_checkin_checkin_id", :name => "foursquare_checkin[checkin_id]"
    end
  end
end
