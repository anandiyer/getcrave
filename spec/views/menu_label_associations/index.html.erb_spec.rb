require 'spec_helper'

describe "menu_label_associations/index.html.haml" do
  before(:each) do
    assign(:menu_label_associations, [
      stub_model(MenuLabelAssociation,
        :menu_item_id => 1,
        :menu_label_id => 1,
        :user_id => 1
      ),
      stub_model(MenuLabelAssociation,
        :menu_item_id => 1,
        :menu_label_id => 1,
        :user_id => 1
      )
    ])
  end

  it "renders a list of menu_label_associations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
