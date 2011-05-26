require 'spec_helper'

describe "users/index.html.erb" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :user_name => "User Name",
        :facebook_id => 1,
        :twitter_id => 1
      ),
      stub_model(User,
        :user_name => "User Name",
        :facebook_id => 1,
        :twitter_id => 1
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "User Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
