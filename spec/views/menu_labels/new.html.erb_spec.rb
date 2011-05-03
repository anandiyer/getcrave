require 'spec_helper'

describe "menu_labels/new.html.erb" do
  before(:each) do
    assign(:menu_label, stub_model(MenuLabel,
      :menu_label => "MyString"
    ).as_new_record)
  end

  it "renders new menu_label form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => menu_labels_path, :method => "post" do
      assert_select "input#menu_label_menu_label", :name => "menu_label[menu_label]"
    end
  end
end
