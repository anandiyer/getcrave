require 'spec_helper'

describe "alpha_testers/show.html.haml" do
  before(:each) do
    @alpha_tester = assign(:alpha_tester, stub_model(AlphaTester,
      :facebook_id => 1,
      :authorized => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
