require 'spec_helper'

describe "ingredients/new.html.erb" do
  before(:each) do
    assign(:ingredient, stub_model(Ingredient,
      :ingredient => "MyString"
    ).as_new_record)
  end

  it "renders new ingredient form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ingredients_path, :method => "post" do
      assert_select "input#ingredient_ingredient", :name => "ingredient[ingredient]"
    end
  end
end
