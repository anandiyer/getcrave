require 'spec_helper'

describe "ingredients/edit.html.erb" do
  before(:each) do
    @ingredient = assign(:ingredient, stub_model(Ingredient,
      :ingredient => "MyString"
    ))
  end

  it "renders the edit ingredient form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ingredients_path(@ingredient), :method => "post" do
      assert_select "input#ingredient_ingredient", :name => "ingredient[ingredient]"
    end
  end
end
