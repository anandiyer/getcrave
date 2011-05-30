require 'spec_helper'

describe "user_followings/new.html.haml" do
  before(:each) do
    assign(:user_following, stub_model(UserFollowing,
      :user_id => 1,
      :following_user_id => 1
    ).as_new_record)
  end

  it "renders new user_following form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_followings_path, :method => "post" do
      assert_select "input#user_following_user_id", :name => "user_following[user_id]"
      assert_select "input#user_following_following_user_id", :name => "user_following[following_user_id]"
    end
  end
end
