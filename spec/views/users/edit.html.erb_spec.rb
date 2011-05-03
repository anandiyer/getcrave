require 'spec_helper'

describe "users/edit.html.erb" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :user_name => "MyString",
      :facebook_id => 1,
      :twitter_id => 1
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path(@user), :method => "post" do
      assert_select "input#user_user_name", :name => "user[user_name]"
      assert_select "input#user_facebook_id", :name => "user[facebook_id]"
      assert_select "input#user_twitter_id", :name => "user[twitter_id]"
    end
  end
end
