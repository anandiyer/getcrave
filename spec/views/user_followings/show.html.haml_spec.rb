require 'spec_helper'

describe "user_followings/show.html.haml" do
  before(:each) do
    @user_following = assign(:user_following, stub_model(UserFollowing,
      :user_id => 1,
      :following_user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
