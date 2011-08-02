class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  layout "general"

  before_filter :get_selected_user, :only => [:saved, :show, :followers, :following]

  # given a provider (facebook/twitter/foursquare) uid, get that user's crave uid
  def get_uid
    @conditions = "provider = \'#{params[:provider]}\' AND uid = \'#{params[:uid]}\'"
    @auth = Authorization.find(:first, :conditions => @conditions)
    
    respond_to do |format|
      format.xml  { render :xml => @auth.to_xml( :include => :user ) }
      format.json  { render :json => @auth.to_json( :include => :user ) }
    end
  end


  def following_reviews
    # 1. find all the people this user is following
    # 2. find all those users reviews ordered reverse chronologically

    @conditions = ""
    @joins = ""

    if (params[:id] && !params[:all])
      @user_id = params[:id] 
    elsif current_user
      @user_id = current_user.id
    end

    if (@user_id)
      @conditions = "user_followings.user_id = #{@user_id}"
      @joins = "INNER JOIN user_followings ON user_followings.following_user_id = menu_item_ratings.user_id"
    end      

    @menu_item_ratings = MenuItemRating.paginate(:all,
      :page => params[:page],
      :per_page => ITEMS_PER_PAGE,
      :joins => @joins,
      :conditions => @conditions,
      :order => 'updated_at DESC')
      
    respond_to do |format|
        format.html
        format.xml  { render :xml => @menu_item_ratings.to_xml(:include => { :user => {}, :menu_item => {:include => [:menu_item_avg_rating_count, :restaurant, :menu_item_photos]} } ) }
        format.json  { render :json => @menu_item_ratings.to_json(:include => { :user => {}, :menu_item => {:include => [:menu_item_avg_rating_count, :restaurant, :menu_item_photos]} } )}
    end
  end

  def index
    if params[:limit] && !params[:limit].empty?
      @limit = params[:limit].to_i
      @users = User.find(:all, :limit => @limit, :order => 'last_logged_in DESC')
    else
      @users = User.find(:all, :order => 'last_logged_in DESC')
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
      format.json  { render :json => @users }
    end
  end


  def followers
    params_4_show_and_saved
    
    @user_id = params[:id]
    @conditions = "following_user_id = #{@user_id}"

    @followers = UserFollowing.paginate(
      :page => params[:page],
      :per_page => ITEMS_PER_PAGE,
      :conditions => @conditions)
    
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @followers.to_xml( :include => :user ) }
      format.json  { render :json => @followers.to_json( :include => :user ) }
    end
  end

  def following
    params_4_show_and_saved
    
    @user_id = params[:id]
    @conditions = "user_id = #{@user_id}"
    
    @following = UserFollowing.paginate(
      :page => params[:page],
      :per_page => ITEMS_PER_PAGE,
      :conditions => @conditions)
    
#    @following = User.find(params[:id]).user_followings
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @following.to_xml( :methods => [:following_user] ) }
      format.json  { render :json => @following.to_json( :methods => [:following_user] ) }
    end
  end

#  to show current user save items
  def saved
    params_4_show_and_saved
    @user_id = params[:id]
    @conditions = "user_id = #{@user_id}"
    
    @user_saved_menu_items = UserSavedMenuItem.paginate(
      :page => params[:page],
      :per_page => ITEMS_PER_PAGE,
      :conditions => @conditions,
      :joins => " LEFT OUTER JOIN menu_item_avg_rating_count ON menu_item_avg_rating_count.menu_item_id = user_saved_menu_items.menu_item_id",
      :order => "(menu_item_avg_rating_count.avg_rating IS NULL) ASC, menu_item_avg_rating_count.avg_rating DESC, menu_item_avg_rating_count.count DESC")
      
      respond_to do |format|
        format.html
        format.xml  { render :xml => @user_saved_menu_items.to_xml }
        format.json  { render :json => @user_saved_menu_items.to_json( :include => { :menu_item => {:include => [:menu_item_avg_rating_count, :restaurant, :menu_item_photos]} } )}
      end
  end


  # GET /users/1
  # GET /users/1.xml
  def show
    params_4_show_and_saved

    @user.this_user = User.find_by_id(params[:current_user_id].to_i)

    respond_to do |format|

      format.html # _unused_show.html.haml
      format.xml  { render :xml => @user.to_xml(:methods => [:following_count, :followers_count, :saved_count, :followed_by_current_user, :following_current_user]) }
      format.json  { render :json => @user.to_json(:methods => [:following_count, :followers_count, :saved_count, :followed_by_current_user, :following_current_user],
        :include => [:authorizations])  }
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
    @user = User.find(params[:id])
  end

  protected
  def get_selected_user
    @selected_user = User.find(params[:user_id] ? params[:user_id] : params[:id])
  end
end
