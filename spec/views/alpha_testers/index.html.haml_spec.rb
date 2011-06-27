require 'spec_helper'

describe "alpha_testers/index.html.haml" do
  before(:each) do
    assign(:alpha_testers, [
      stub_model(AlphaTester,
        :facebook_id => 1,
        :authorized => false
      ),
      stub_model(AlphaTester,
        :facebook_id => 1,
        :authorized => false
      )
    ])
  end

  it "renders a list of alpha_testers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
