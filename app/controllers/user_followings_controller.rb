class UserFollowingsController < ApplicationController
  layout "general"
  before_filter :get_user

  
  # GET /user_followings
  # GET /user_followings.xml
  def index
    if (@user)
      @user_followings = @user.user_followings.find(:all)
    else
      @user_followings = UserFollowing.all
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_followings }
      format.json  { render :json => @user_followings }
    end
  end

  # GET /user_followings/1
  # GET /user_followings/1.xml
  def show
    @user_following = UserFollowing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_following }
      format.json  { render :json => @user_following }
    end
  end

  # GET /user_followings/new
  # GET /user_followings/new.xml
  def new
    @user_following = UserFollowing.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_following }
      format.json  { render :json => @user_following }
    end
  end

  # GET /user_followings/1/edit
  def edit
    @user_following = UserFollowing.find(params[:id])
  end

  # POST /user_followings
  # POST /user_followings.xml
  def create
    @user_following = UserFollowing.new(params[:user_following])

    respond_to do |format|
      if @user_following.save
        format.html { redirect_to(@user_following, :notice => 'User following was successfully created.') }
        format.xml  { render :xml => @user_following, :status => :created, :location => @user_following }
        format.json  { render :json => @user_following, :status => :created, :location => @user_following }
        format.js  { render :js => "window.make_unfollow()" }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_following.errors, :status => :unprocessable_entity }
        format.json  { render :json => @user_following.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_followings/1
  # PUT /user_followings/1.xml
  def update
    @user_following = UserFollowing.find(params[:id])

    respond_to do |format|
      if @user_following.update_attributes(params[:user_following])
        format.html { redirect_to(@user_following, :notice => 'User following was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_following.errors, :status => :unprocessable_entity }
        format.json  { render :xml => @user_following.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_followings/1
  # DELETE /user_followings/1.xml
  def destroy
    #TODO: a user can only unfollow someone they are following


#    UserFollowing.find(params[:id])
    p @user_following = UserFollowing.where(:user_id => current_user.id, :following_user_id => params[:id]).first
    @user_following.destroy
#
    respond_to do |format|
#      format.html { redirect_to(user_followings_url) }
#      format.xml  { head :ok }
#      format.json  { head :ok }
      format.js  { head :ok }
    end
  end
  
  private
    def get_user
      @user = User.find(params[:user_id]) unless params[:user_id].blank?
    end
end
