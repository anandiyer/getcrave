require 'spec_helper'

describe "ingredients/show.html.haml" do
  before(:each) do
    @ingredient = assign(:ingredient, stub_model(Ingredient,
      :ingredient => "Ingredient"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ingredient/)
  end
end
