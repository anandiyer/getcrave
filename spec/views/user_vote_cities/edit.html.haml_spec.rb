require 'spec_helper'

describe "user_vote_cities/edit.html.haml" do
  before(:each) do
    @user_vote_city = assign(:user_vote_city, stub_model(UserVoteCity,
      :email => "MyString",
      :city => "MyString",
      :state => "MyString",
      :country => "MyString",
      :latitude => 1.5,
      :longitude => 1.5
    ))
  end

  it "renders the edit user_vote_city form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_vote_cities_path(@user_vote_city), :method => "post" do
      assert_select "input#user_vote_city_email", :name => "user_vote_city[email]"
      assert_select "input#user_vote_city_city", :name => "user_vote_city[city]"
      assert_select "input#user_vote_city_state", :name => "user_vote_city[state]"
      assert_select "input#user_vote_city_country", :name => "user_vote_city[country]"
      assert_select "input#user_vote_city_latitude", :name => "user_vote_city[latitude]"
      assert_select "input#user_vote_city_longitude", :name => "user_vote_city[longitude]"
    end
  end
end
