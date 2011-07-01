require 'spec_helper'

describe "foursquare_checkins/show.html.haml" do
  before(:each) do
    @foursquare_checkin = assign(:foursquare_checkin, stub_model(FoursquareCheckin,
      :venue_id => "Venue",
      :user_id => 1,
      :checkin_id => "Checkin"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Venue/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Checkin/)
  end
end
