require 'spec_helper'

describe "user_vote_cities/index.html.haml" do
  before(:each) do
    assign(:user_vote_cities, [
      stub_model(UserVoteCity,
        :email => "Email",
        :city => "City",
        :state => "State",
        :country => "Country",
        :latitude => 1.5,
        :longitude => 1.5
      ),
      stub_model(UserVoteCity,
        :email => "Email",
        :city => "City",
        :state => "State",
        :country => "Country",
        :latitude => 1.5,
        :longitude => 1.5
      )
    ])
  end

  it "renders a list of user_vote_cities" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "State".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
