require 'spec_helper'

describe "alpha_testers/edit.html.haml" do
  before(:each) do
    @alpha_tester = assign(:alpha_tester, stub_model(AlphaTester,
      :facebook_id => 1,
      :authorized => false
    ))
  end

  it "renders the edit alpha_tester form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => alpha_testers_path(@alpha_tester), :method => "post" do
      assert_select "input#alpha_tester_facebook_id", :name => "alpha_tester[facebook_id]"
      assert_select "input#alpha_tester_authorized", :name => "alpha_tester[authorized]"
    end
  end
end
