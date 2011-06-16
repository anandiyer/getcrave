class UserSavedMenuItemsController < ApplicationController
  before_filter :get_user, :check_auth_fb

  layout "general"



  def show_menu_items_saved
    params_for_index_and_show_menu_items_saved
    render :partial => "/items_grouped_by_stars"
  end


  # GET /user_saved_menu_items
  # GET /user_saved_menu_items.xml
  def index
#    if (@user)
#       @user_saved_menu_items = @user.user_saved_menu_items.find(:all)
#     else
#       @user_saved_menu_items = UserSavedMenuItem.all
#     end

#    @user_saved_menu_items = MenuItem
     
    params_for_index_and_show_menu_items_saved

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_saved_menu_items }
      format.json  { render :json => @user_saved_menu_items }
    end
  end

  # GET /user_saved_menu_items/1
  # GET /user_saved_menu_items/1.xml
  def show
    @user_saved_menu_item = UserSavedMenuItem.find(params[:id])

    respond_to do |format|
      format.html # _unused_show.html.haml
      format.xml  { render :xml => @user_saved_menu_item }
      format.json  { render :json => @user_saved_menu_item }
    end
  end

  # GET /user_saved_menu_items/new
  # GET /user_saved_menu_items/new.xml
  def new
    @user_saved_menu_item = UserSavedMenuItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_saved_menu_item }
      format.json  { render :json => @user_saved_menu_item }
    end
  end

  # GET /user_saved_menu_items/1/edit
  def edit
    @user_saved_menu_item = UserSavedMenuItem.find(params[:id])
  end

  # POST /user_saved_menu_items
  # POST /user_saved_menu_items.xml
  def create
    @user_saved_menu_item = UserSavedMenuItem.new(params[:user_saved_menu_item])
    p @user_saved_menu_item.id

    respond_to do |format|
      p @user_saved_menu_item.save

      if t
        format.html { redirect_to(@user_saved_menu_item, :notice => 'User saved menu item was successfully created.') }
        format.xml  { render :xml => @user_saved_menu_item, :status => :created, :location => @user_saved_menu_item }
        format.json  { render :json => @user_saved_menu_item, :status => :created, :location => @user_saved_menu_item }
        format.js  { render :js => "window.save_menu_item("+params[:user_saved_menu_item][:menu_item_id]+","+@user_saved_menu_item.id.to_s+")" }
      end
    end
  end

  # PUT /user_saved_menu_items/1
  # PUT /user_saved_menu_items/1.xml
  def update
    @user_saved_menu_item = UserSavedMenuItem.find(params[:id])

    respond_to do |format|
      if @user_saved_menu_item.update_attributes(params[:user_saved_menu_item])
        format.html { redirect_to(@user_saved_menu_item, :notice => 'User saved menu item was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_saved_menu_item.errors, :status => :unprocessable_entity }
        format.json  { render :json => @user_saved_menu_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_saved_menu_items/1
  # DELETE /user_saved_menu_items/1.xml
  def destroy
    @user_saved_menu_item = UserSavedMenuItem.find(params[:id])
    @user_saved_menu_item.destroy

    respond_to do |format|
       format.js { render :js => "window.unsave_menu_item(#{@user_saved_menu_item.menu_item.id})" }
#      format.all { render :js =>"alert(1)" }
#      format.all { render :partial => "/save" }
#      format.all { redirect_to(user_saved_menu_items_url) }
#      format.xml  { head :ok }
#      format.json  { head :ok }
#      format.js  { render :js =>"alert(1)"  }
    end
  end

  private
  def get_user
    if !params[:user_id]
      @user = current_user
    else
      @user = User.find(params[:user_id]) unless params[:user_id].blank?
    end
  end

  def params_for_index_and_show_menu_items_saved
    if !params[:limit].nil?
      @limit = params[:limit]
    else
      @limit = ITEMS_PER_PAGE
    end

#    TODO: its not real saved items

    @menu_items = MenuItem.find(:all,
          :joins => " LEFT OUTER JOIN menu_item_avg_rating_count ON menu_item_avg_rating_count.menu_item_id = menu_items.id",
          :order => "(menu_item_avg_rating_count.avg_rating IS NULL) ASC, menu_item_avg_rating_count.avg_rating DESC, menu_item_avg_rating_count.count DESC",
          # :include => :menu_item_avg_rating_count,
          :limit => @limit)

  end
  
end
