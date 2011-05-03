require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe MenuItemReviewCommentsController do

  def mock_menu_item_review_comment(stubs={})
    @mock_menu_item_review_comment ||= mock_model(MenuItemReviewComment, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all menu_item_review_comments as @menu_item_review_comments" do
      MenuItemReviewComment.stub(:all) { [mock_menu_item_review_comment] }
      get :index
      assigns(:menu_item_review_comments).should eq([mock_menu_item_review_comment])
    end
  end

  describe "GET show" do
    it "assigns the requested menu_item_review_comment as @menu_item_review_comment" do
      MenuItemReviewComment.stub(:find).with("37") { mock_menu_item_review_comment }
      get :show, :id => "37"
      assigns(:menu_item_review_comment).should be(mock_menu_item_review_comment)
    end
  end

  describe "GET new" do
    it "assigns a new menu_item_review_comment as @menu_item_review_comment" do
      MenuItemReviewComment.stub(:new) { mock_menu_item_review_comment }
      get :new
      assigns(:menu_item_review_comment).should be(mock_menu_item_review_comment)
    end
  end

  describe "GET edit" do
    it "assigns the requested menu_item_review_comment as @menu_item_review_comment" do
      MenuItemReviewComment.stub(:find).with("37") { mock_menu_item_review_comment }
      get :edit, :id => "37"
      assigns(:menu_item_review_comment).should be(mock_menu_item_review_comment)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created menu_item_review_comment as @menu_item_review_comment" do
        MenuItemReviewComment.stub(:new).with({'these' => 'params'}) { mock_menu_item_review_comment(:save => true) }
        post :create, :menu_item_review_comment => {'these' => 'params'}
        assigns(:menu_item_review_comment).should be(mock_menu_item_review_comment)
      end

      it "redirects to the created menu_item_review_comment" do
        MenuItemReviewComment.stub(:new) { mock_menu_item_review_comment(:save => true) }
        post :create, :menu_item_review_comment => {}
        response.should redirect_to(menu_item_review_comment_url(mock_menu_item_review_comment))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved menu_item_review_comment as @menu_item_review_comment" do
        MenuItemReviewComment.stub(:new).with({'these' => 'params'}) { mock_menu_item_review_comment(:save => false) }
        post :create, :menu_item_review_comment => {'these' => 'params'}
        assigns(:menu_item_review_comment).should be(mock_menu_item_review_comment)
      end

      it "re-renders the 'new' template" do
        MenuItemReviewComment.stub(:new) { mock_menu_item_review_comment(:save => false) }
        post :create, :menu_item_review_comment => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested menu_item_review_comment" do
        MenuItemReviewComment.stub(:find).with("37") { mock_menu_item_review_comment }
        mock_menu_item_review_comment.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :menu_item_review_comment => {'these' => 'params'}
      end

      it "assigns the requested menu_item_review_comment as @menu_item_review_comment" do
        MenuItemReviewComment.stub(:find) { mock_menu_item_review_comment(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:menu_item_review_comment).should be(mock_menu_item_review_comment)
      end

      it "redirects to the menu_item_review_comment" do
        MenuItemReviewComment.stub(:find) { mock_menu_item_review_comment(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(menu_item_review_comment_url(mock_menu_item_review_comment))
      end
    end

    describe "with invalid params" do
      it "assigns the menu_item_review_comment as @menu_item_review_comment" do
        MenuItemReviewComment.stub(:find) { mock_menu_item_review_comment(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:menu_item_review_comment).should be(mock_menu_item_review_comment)
      end

      it "re-renders the 'edit' template" do
        MenuItemReviewComment.stub(:find) { mock_menu_item_review_comment(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested menu_item_review_comment" do
      MenuItemReviewComment.stub(:find).with("37") { mock_menu_item_review_comment }
      mock_menu_item_review_comment.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the menu_item_review_comments list" do
      MenuItemReviewComment.stub(:find) { mock_menu_item_review_comment }
      delete :destroy, :id => "1"
      response.should redirect_to(menu_item_review_comments_url)
    end
  end

end
