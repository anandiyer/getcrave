class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  layout "general"

  before_filter :get_selected_user, :only => [:saved, :show, :followers, :following]

  def index
    
    if params[:limit] && !params[:limit].empty?
      @limit = params[:limit].to_i
      @users = User.find(:all, :limit => @limit)
    else
      @users = User.find(:all)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
      format.xml  { render :json => @users }
    end
  end


  def followers
    params_4_show_and_saved
#    @followers = UserFollowing.where(:following_user_id => 12).all
    @followers = UserFollowing.where(:following_user_id => params[:id])
  end

  def following
    params_4_show_and_saved
    @following = User.find(params[:id]).user_followings
  end

#  to show current user save items
  def saved
    params_4_show_and_saved
    @user_saved_menu_items = User.find(params[:id]).saved if current_user
  end


  # GET /users/1
  # GET /users/1.xml
  def show
    params_4_show_and_saved

    respond_to do |format|

      format.html # _unused_show.html.haml
      format.xml  { render :xml => @user.to_xml( :include => :menu_item_ratings ) }
      format.json  { render :json => @user.to_json( :include => :menu_item_ratings ) }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
      format.json  { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
        format.json  { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.xml  { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.json  { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    # @user = User.find(params[:id])
    # @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end


  private

  def params_4_show_and_saved
    @user = User.find(params[:id], :include => :menu_item_ratings)
  end

  protected
  def get_selected_user
    @selected_user = User.find(params[:user_id] ? params[:user_id] : params[:id])
  end
end
