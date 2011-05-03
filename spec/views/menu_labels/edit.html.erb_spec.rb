require 'spec_helper'

describe "menu_labels/edit.html.erb" do
  before(:each) do
    @menu_label = assign(:menu_label, stub_model(MenuLabel,
      :menu_label => "MyString"
    ))
  end

  it "renders the edit menu_label form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => menu_labels_path(@menu_label), :method => "post" do
      assert_select "input#menu_label_menu_label", :name => "menu_label[menu_label]"
    end
  end
end
