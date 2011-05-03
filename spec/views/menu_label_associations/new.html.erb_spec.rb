require 'spec_helper'

describe "menu_label_associations/new.html.erb" do
  before(:each) do
    assign(:menu_label_association, stub_model(MenuLabelAssociation,
      :menu_item_id => 1,
      :menu_label_id => 1,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new menu_label_association form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => menu_label_associations_path, :method => "post" do
      assert_select "input#menu_label_association_menu_item_id", :name => "menu_label_association[menu_item_id]"
      assert_select "input#menu_label_association_menu_label_id", :name => "menu_label_association[menu_label_id]"
      assert_select "input#menu_label_association_user_id", :name => "menu_label_association[user_id]"
    end
  end
end
