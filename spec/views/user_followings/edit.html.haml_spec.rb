require 'spec_helper'

describe "user_followings/edit.html.haml" do
  before(:each) do
    @user_following = assign(:user_following, stub_model(UserFollowing,
      :user_id => 1,
      :following_user_id => 1
    ))
  end

  it "renders the edit user_following form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_followings_path(@user_following), :method => "post" do
      assert_select "input#user_following_user_id", :name => "user_following[user_id]"
      assert_select "input#user_following_following_user_id", :name => "user_following[following_user_id]"
    end
  end
end
