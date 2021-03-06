require 'spec_helper'

describe "menu_labels/index.html.erb" do
  before(:each) do
    assign(:menu_labels, [
      stub_model(MenuLabel,
        :menu_label => "Menu Label"
      ),
      stub_model(MenuLabel,
        :menu_label => "Menu Label"
      )
    ])
  end

  it "renders a list of menu_labels" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Menu Label".to_s, :count => 2
  end
end
