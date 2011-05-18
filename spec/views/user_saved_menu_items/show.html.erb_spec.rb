require 'spec_helper'

describe "user_saved_menu_items/show.html.haml" do
  before(:each) do
    @user_saved_menu_item = assign(:user_saved_menu_item, stub_model(UserSavedMenuItem,
      :user_id => 1,
      :menu_item_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
