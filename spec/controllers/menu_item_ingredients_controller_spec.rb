require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe MenuItemIngredientsController do

  def mock_menu_item_ingredient(stubs={})
    @mock_menu_item_ingredient ||= mock_model(MenuItemIngredient, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all menu_item_ingredients as @menu_item_ingredients" do
      MenuItemIngredient.stub(:all) { [mock_menu_item_ingredient] }
      get :index
      assigns(:menu_item_ingredients).should eq([mock_menu_item_ingredient])
    end
  end

  describe "GET show" do
    it "assigns the requested menu_item_ingredient as @menu_item_ingredient" do
      MenuItemIngredient.stub(:find).with("37") { mock_menu_item_ingredient }
      get :show, :id => "37"
      assigns(:menu_item_ingredient).should be(mock_menu_item_ingredient)
    end
  end

  describe "GET new" do
    it "assigns a new menu_item_ingredient as @menu_item_ingredient" do
      MenuItemIngredient.stub(:new) { mock_menu_item_ingredient }
      get :new
      assigns(:menu_item_ingredient).should be(mock_menu_item_ingredient)
    end
  end

  describe "GET edit" do
    it "assigns the requested menu_item_ingredient as @menu_item_ingredient" do
      MenuItemIngredient.stub(:find).with("37") { mock_menu_item_ingredient }
      get :edit, :id => "37"
      assigns(:menu_item_ingredient).should be(mock_menu_item_ingredient)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created menu_item_ingredient as @menu_item_ingredient" do
        MenuItemIngredient.stub(:new).with({'these' => 'params'}) { mock_menu_item_ingredient(:save => true) }
        post :create, :menu_item_ingredient => {'these' => 'params'}
        assigns(:menu_item_ingredient).should be(mock_menu_item_ingredient)
      end

      it "redirects to the created menu_item_ingredient" do
        MenuItemIngredient.stub(:new) { mock_menu_item_ingredient(:save => true) }
        post :create, :menu_item_ingredient => {}
        response.should redirect_to(menu_item_ingredient_url(mock_menu_item_ingredient))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved menu_item_ingredient as @menu_item_ingredient" do
        MenuItemIngredient.stub(:new).with({'these' => 'params'}) { mock_menu_item_ingredient(:save => false) }
        post :create, :menu_item_ingredient => {'these' => 'params'}
        assigns(:menu_item_ingredient).should be(mock_menu_item_ingredient)
      end

      it "re-renders the 'new' template" do
        MenuItemIngredient.stub(:new) { mock_menu_item_ingredient(:save => false) }
        post :create, :menu_item_ingredient => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested menu_item_ingredient" do
        MenuItemIngredient.stub(:find).with("37") { mock_menu_item_ingredient }
        mock_menu_item_ingredient.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :menu_item_ingredient => {'these' => 'params'}
      end

      it "assigns the requested menu_item_ingredient as @menu_item_ingredient" do
        MenuItemIngredient.stub(:find) { mock_menu_item_ingredient(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:menu_item_ingredient).should be(mock_menu_item_ingredient)
      end

      it "redirects to the menu_item_ingredient" do
        MenuItemIngredient.stub(:find) { mock_menu_item_ingredient(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(menu_item_ingredient_url(mock_menu_item_ingredient))
      end
    end

    describe "with invalid params" do
      it "assigns the menu_item_ingredient as @menu_item_ingredient" do
        MenuItemIngredient.stub(:find) { mock_menu_item_ingredient(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:menu_item_ingredient).should be(mock_menu_item_ingredient)
      end

      it "re-renders the 'edit' template" do
        MenuItemIngredient.stub(:find) { mock_menu_item_ingredient(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested menu_item_ingredient" do
      MenuItemIngredient.stub(:find).with("37") { mock_menu_item_ingredient }
      mock_menu_item_ingredient.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the menu_item_ingredients list" do
      MenuItemIngredient.stub(:find) { mock_menu_item_ingredient }
      delete :destroy, :id => "1"
      response.should redirect_to(menu_item_ingredients_url)
    end
  end

end
