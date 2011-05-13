require 'spec_helper'

describe "menu_label_associations/show.html.haml" do
  before(:each) do
    @menu_label_association = assign(:menu_label_association, stub_model(MenuLabelAssociation,
      :menu_item_id => 1,
      :menu_label_id => 1,
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
