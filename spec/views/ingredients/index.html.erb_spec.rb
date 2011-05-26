require 'spec_helper'

describe "ingredients/index.html.erb" do
  before(:each) do
    assign(:ingredients, [
      stub_model(Ingredient,
        :ingredient => "Ingredient"
      ),
      stub_model(Ingredient,
        :ingredient => "Ingredient"
      )
    ])
  end

  it "renders a list of ingredients" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ingredient".to_s, :count => 2
  end
end
