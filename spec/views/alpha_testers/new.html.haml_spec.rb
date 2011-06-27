require 'spec_helper'

describe "alpha_testers/new.html.haml" do
  before(:each) do
    assign(:alpha_tester, stub_model(AlphaTester,
      :facebook_id => 1,
      :authorized => false
    ).as_new_record)
  end

  it "renders new alpha_tester form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => alpha_testers_path, :method => "post" do
      assert_select "input#alpha_tester_facebook_id", :name => "alpha_tester[facebook_id]"
      assert_select "input#alpha_tester_authorized", :name => "alpha_tester[authorized]"
    end
  end
end
