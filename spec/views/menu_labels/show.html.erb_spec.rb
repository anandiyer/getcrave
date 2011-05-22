require 'spec_helper'

describe "menu_labels/_unused_show.html.haml" do
  before(:each) do
    @menu_label = assign(:menu_label, stub_model(MenuLabel,
      :menu_label => "Menu Label"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Menu Label/)
  end
end
