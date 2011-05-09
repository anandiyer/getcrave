require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe RestaurantLabelsController do

  def mock_restaurant_label(stubs={})
    @mock_restaurant_label ||= mock_model(RestaurantLabel, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all restaurant_labels as @restaurant_labels" do
      RestaurantLabel.stub(:all) { [mock_restaurant_label] }
      get :index
      assigns(:restaurant_labels).should eq([mock_restaurant_label])
    end
  end

  describe "GET show" do
    it "assigns the requested restaurant_label as @restaurant_label" do
      RestaurantLabel.stub(:find).with("37") { mock_restaurant_label }
      get :show, :id => "37"
      assigns(:restaurant_label).should be(mock_restaurant_label)
    end
  end

  describe "GET new" do
    it "assigns a new restaurant_label as @restaurant_label" do
      RestaurantLabel.stub(:new) { mock_restaurant_label }
      get :new
      assigns(:restaurant_label).should be(mock_restaurant_label)
    end
  end

  describe "GET edit" do
    it "assigns the requested restaurant_label as @restaurant_label" do
      RestaurantLabel.stub(:find).with("37") { mock_restaurant_label }
      get :edit, :id => "37"
      assigns(:restaurant_label).should be(mock_restaurant_label)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created restaurant_label as @restaurant_label" do
        RestaurantLabel.stub(:new).with({'these' => 'params'}) { mock_restaurant_label(:save => true) }
        post :create, :restaurant_label => {'these' => 'params'}
        assigns(:restaurant_label).should be(mock_restaurant_label)
      end

      it "redirects to the created restaurant_label" do
        RestaurantLabel.stub(:new) { mock_restaurant_label(:save => true) }
        post :create, :restaurant_label => {}
        response.should redirect_to(restaurant_label_url(mock_restaurant_label))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved restaurant_label as @restaurant_label" do
        RestaurantLabel.stub(:new).with({'these' => 'params'}) { mock_restaurant_label(:save => false) }
        post :create, :restaurant_label => {'these' => 'params'}
        assigns(:restaurant_label).should be(mock_restaurant_label)
      end

      it "re-renders the 'new' template" do
        RestaurantLabel.stub(:new) { mock_restaurant_label(:save => false) }
        post :create, :restaurant_label => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested restaurant_label" do
        RestaurantLabel.stub(:find).with("37") { mock_restaurant_label }
        mock_restaurant_label.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :restaurant_label => {'these' => 'params'}
      end

      it "assigns the requested restaurant_label as @restaurant_label" do
        RestaurantLabel.stub(:find) { mock_restaurant_label(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:restaurant_label).should be(mock_restaurant_label)
      end

      it "redirects to the restaurant_label" do
        RestaurantLabel.stub(:find) { mock_restaurant_label(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(restaurant_label_url(mock_restaurant_label))
      end
    end

    describe "with invalid params" do
      it "assigns the restaurant_label as @restaurant_label" do
        RestaurantLabel.stub(:find) { mock_restaurant_label(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:restaurant_label).should be(mock_restaurant_label)
      end

      it "re-renders the 'edit' template" do
        RestaurantLabel.stub(:find) { mock_restaurant_label(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested restaurant_label" do
      RestaurantLabel.stub(:find).with("37") { mock_restaurant_label }
      mock_restaurant_label.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the restaurant_labels list" do
      RestaurantLabel.stub(:find) { mock_restaurant_label }
      delete :destroy, :id => "1"
      response.should redirect_to(restaurant_labels_url)
    end
  end

end