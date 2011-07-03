class MenuItemRatingsController < ApplicationController
  before_filter :get_menu_item, :check_auth_fb, :get_user

  # GET /menu_items_ratings/avg_rating
  def avg_rating
    #FIXME - use the SQL view instead

    average = @menu_item.menu_item_ratings.average(:rating)
    count = @menu_item.menu_item_ratings.count
    @response = {:average => average, :count => count}

    respond_to do |format|
      format.json { render :json => @response.to_json }
    end
  end

  # GET /menu_item_ratings
  # GET /menu_item_ratings.xml
  def index
    #@menu_item_ratings = MenuItemRating.all

    if (@menu_item)
      @menu_item_ratings = @menu_item.menu_item_ratings.find(:all)
    elsif (@user)
      @menu_item_ratings = @user.menu_item_ratings.paginate(:all,:page => params[:page],:per_page => ITEMS_PER_PAGE)
    else
      @menu_item_ratings = MenuItemRating.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @menu_item_ratings }
      format.json { render :json => @menu_item_ratings }
    end
  end

  # GET /menu_item_ratings/1
  # GET /menu_item_ratings/1.xml
  def show
    #@menu_item_rating = @menu_item.menu_item_ratings.find(params[:id])

    @menu_item_rating = MenuItemRating.find(params[:id])

    respond_to do |format|
      format.html # _unused_show.html.haml
      format.xml { render :xml => @menu_item_rating }
      format.json { render :json => @menu_item_rating }
    end
  end

  # GET /menu_item_ratings/new
  # GET /menu_item_ratings/new.xml
  def new
    @menu_item_rating = MenuItemRating.new
    @menu_item_rating.menu_item_id = params[:menu_item_id]
    @menu_item_rating.user_id = current_user.id if current_user

    respond_to do |format|
      # FIXME
      format.html # new.html.erb
      format.xml { render :xml => @menu_item_rating }
      format.json { render :json => @menu_item_rating }
    end
  end

  # GET /menu_item_ratings/1/edit
  def edit
    @menu_item_rating = MenuItemRating.find(params[:id])
  end


  def send_to_fb_wall
      menu_item_id = params[:menu_item_rating][:menu_item_id]
      menu_item = MenuItem.find(menu_item_id)
      name = menu_item.name
      link = "http://getcrave.com/items/"+params[:menu_item_rating][:menu_item_id]
      message = "I just craved the #{name} - "+link
      picture = menu_item.thumbnail.index("amazonaws").nil? ? "http://getcrave.com/images/"+menu_item.thumbnail : menu_item.thumbnail
      desc = menu_item.description ? menu_item.description : "Have you ever been to a restaurant and asked, “So, what’s good here?” We help people find the food they like."

      token = current_user.authorizations.first.token

      me = FbGraph::User.me(token)
      me.feed!(
          :message => message,
          :picture => picture,
          :link => link,
          :name => name,
          :description => desc
      )

  end

  # POST /menu_item_ratings
  # POST /menu_item_ratings.xml
  def create
      if params[:facebook][:boolean] == "1"

        if current_user.authorizations.first.token.blank?
          session[:user_id] = nil
          session[:redirect_to] = nil
          render :text => "no_token"
          return
        else
          send_to_fb_wall
        end
      end

      @menu_item_rating = MenuItemRating.new(params[:menu_item_rating])

      if current_user
        @menu_item_rating.user_id = current_user.id
      else
#      TODO: destroy this line after restore facebook auth
        unknown_user = User.find_or_create_by_user_name("Unknown user")
        @menu_item_rating.user_id = unknown_user.id
      end

      respond_to { |format|
        if @menu_item_rating.save
          format.html { redirect_to(@menu_item_rating, :notice => 'Menu item rating was successfully created.') }
          format.xml { render :xml => @menu_item_rating, :status => :created, :location => @menu_item_rating }
          format.json { render :json => @menu_item_rating, :status => :created, :location => @menu_item_rating }
          format.js {
#          TODO: change temp number to real
#          if !params[:menu_item_rating][:rating].empty?
#            message = "You rated this dish with <b>"+params[:menu_item_rating][:rating]+"</b> stars!"
#          else
#            message = "Your review was successfully added"
#          end
            message = "Thanks for your review, "+@current_user.user_name+"!"
            render :js => "window.add_review(#{params[:menu_item_rating][:menu_item_id]},'#{message}')"
            @current_user
          }
        else
          format.html { render :action => "new" }
          format.xml { render :xml => @menu_item_rating.errors, :status => :unprocessable_entity }
          format.json { render :json => @menu_item_rating.errors, :status => :unprocessable_entity }
        end }

  end

  # PUT /menu_item_ratings/1
  # PUT /menu_item_ratings/1.xml
  def update
    @menu_item_rating = MenuItemRating.find(params[:id])

    respond_to do |format|
      if @menu_item_rating.update_attributes(params[:menu_item_rating])
        format.html { redirect_to(@menu_item_rating, :notice => 'Menu item rating was successfully updated.') }
        format.xml { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @menu_item_rating.errors, :status => :unprocessable_entity }
        format.json { render :json => @menu_item_rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_item_ratings/1
  # DELETE /menu_item_ratings/1.xml
  def destroy
    @menu_item_rating = MenuItemRating.find(params[:id])
    @menu_item_rating.destroy

    respond_to do |format|
      format.html { redirect_to(menu_item_ratings_url) }
      format.xml { head :ok }
      format.json { head :ok }
    end
  end

  private
    def get_menu_item
      @menu_item = MenuItem.find(params[:menu_item_id]) unless params[:menu_item_id].blank?
    end
  
    def get_user
      @user = User.find(params[:user_id]) unless params[:user_id].blank?
    end
  
end
