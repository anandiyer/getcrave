class MenuItemReviewCommentsController < ApplicationController
  # GET /menu_item_review_comments
  # GET /menu_item_review_comments.xml
  def index
    @menu_item_review_comments = MenuItemReviewComment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @menu_item_review_comments }
    end
  end

  # GET /menu_item_review_comments/1
  # GET /menu_item_review_comments/1.xml
  def show
    @menu_item_review_comment = MenuItemReviewComment.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @menu_item_review_comment }
    end
  end

  # GET /menu_item_review_comments/new
  # GET /menu_item_review_comments/new.xml
  def new
    @menu_item_review_comment = MenuItemReviewComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @menu_item_review_comment }
    end
  end

  # GET /menu_item_review_comments/1/edit
  def edit
    @menu_item_review_comment = MenuItemReviewComment.find(params[:id])
  end

  # POST /menu_item_review_comments
  # POST /menu_item_review_comments.xml
  def create
    @menu_item_review_comment = MenuItemReviewComment.new(params[:menu_item_review_comment])

    respond_to do |format|
      if @menu_item_review_comment.save
        format.html { redirect_to(@menu_item_review_comment, :notice => 'Menu item review comment was successfully created.') }
        format.xml  { render :xml => @menu_item_review_comment, :status => :created, :location => @menu_item_review_comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @menu_item_review_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /menu_item_review_comments/1
  # PUT /menu_item_review_comments/1.xml
  def update
    @menu_item_review_comment = MenuItemReviewComment.find(params[:id])

    respond_to do |format|
      if @menu_item_review_comment.update_attributes(params[:menu_item_review_comment])
        format.html { redirect_to(@menu_item_review_comment, :notice => 'Menu item review comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menu_item_review_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_item_review_comments/1
  # DELETE /menu_item_review_comments/1.xml
  def destroy
    @menu_item_review_comment = MenuItemReviewComment.find(params[:id])
    @menu_item_review_comment.destroy

    respond_to do |format|
      format.html { redirect_to(menu_item_review_comments_url) }
      format.xml  { head :ok }
    end
  end
end
