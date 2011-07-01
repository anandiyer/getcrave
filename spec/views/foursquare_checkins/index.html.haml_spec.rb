require 'spec_helper'

describe "foursquare_checkins/index.html.haml" do
  before(:each) do
    assign(:foursquare_checkins, [
      stub_model(FoursquareCheckin,
        :venue_id => "Venue",
        :user_id => 1,
        :checkin_id => "Checkin"
      ),
      stub_model(FoursquareCheckin,
        :venue_id => "Venue",
        :user_id => 1,
        :checkin_id => "Checkin"
      )
    ])
  end

  it "renders a list of foursquare_checkins" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Venue".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Checkin".to_s, :count => 2
  end
end
