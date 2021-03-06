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
      @menu_item_ratings = @menu_item.menu_item_ratings.find(:all, :order => 'created_at DESC')
    elsif (@user)
      @menu_item_ratings = @user.menu_item_ratings.paginate(:all,
        :page => params[:page],
        :per_page => ITEMS_PER_PAGE,
        :order => 'created_at DESC')
    else
      @menu_item_ratings = MenuItemRating.find(:all, :order => 'created_at DESC')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @menu_item_ratings.to_xml(:include => {:menu_item => {:include => [:restaurant, :menu_item_photos]} }) }
      format.json { render :json => @menu_item_ratings.to_json(:include => {:menu_item => {:include => [:restaurant, :menu_item_photos]} })}
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

  def send_to_twitter
    # For API requests we have to get the current user from the menu_item_rating param
    if (!current_user || current_user.nil?)
      user = @menu_item_rating.user
    else
      user = current_user
    end
    
    # Only send to Twitter if in fact, this user's twitter account exists
    auth = Authorization.find(:first, :conditions => {:user_id => user.id, :provider => 'twitter'})
    
    if (!auth || auth.token.empty? || auth.secret.empty?)
      return
    end
    
    Twitter.configure do |config|
      config.consumer_key = TWITTER_APP_ID
      config.consumer_secret = TWITTER_APP_SECRET
      config.oauth_token = auth.token
      config.oauth_token_secret = auth.secret
    end

    menu_item_id = params[:menu_item_rating][:menu_item_id]
    
    menu_item = MenuItem.find_by_id(menu_item_id)
    menu_item_friendly_id = menu_item.friendly_id
    
    review = "Check out my review of the " + menu_item.name + " @"
  
    if (!menu_item.restaurant.twitter.empty?)
      review = review + menu_item.restaurant.twitter
    else
      review = review + " " + menu_item.restaurant.name
    end
    
    review = review + " on crave"
    
    menu_item_rating_id = @menu_item_rating.id.to_s
    link = "http://getcrave.com/items/"+menu_item_friendly_id+"#"+menu_item_rating_id
    message = review + " - " + link

    client = Twitter::Client.new
    begin
      client.update(message)
      return true
    rescue Exception => e
      p "Unable to send to twitter: #{e.to_s}"
      return false
    end
    
  end


  def send_to_fb_wall
    
    # For API requests we have to get the current user from the menu_item_rating param
    if (!current_user || current_user.nil?)
      user = @menu_item_rating.user
    else
      user = current_user
    end
    
    auth = Authorization.find(:first, :conditions => {:user_id => user.id, :provider => 'facebook'})
    
    # Only send to FB wall if in fact, this user's FB account exists
    if (!auth || auth.token.empty?)
      return
    end
    
    menu_item_id = params[:menu_item_rating][:menu_item_id]
    
    menu_item = MenuItem.find_by_id(menu_item_id)
    menu_item_friendly_id = menu_item.friendly_id
    name = menu_item.name
    
    review = params[:menu_item_rating][:review] ? 
      params[:menu_item_rating][:review] : "Check out my review of the " + name + " on crave"
    
    menu_item_rating_id = @menu_item_rating.id.to_s
    link = "http://getcrave.com/items/"+menu_item_friendly_id+"#"+menu_item_rating_id
    message = review + " - " + link 
    picture = menu_item.thumbnail.index("amazonaws").nil? ? "http://getcrave.com/images/"+menu_item.thumbnail : menu_item.thumbnail
    desc = menu_item.description ? menu_item.description : 
      "Have you ever been to a restaurant or a bar and asked, \'so, what\'s good here\?"

    me = FbGraph::User.me(auth.token)
    me.feed!(:message => message,
          :picture => picture,
          :link => link,
          :name => name,
          :description => desc)
  end
  
  def send_to_foursquare
    # For API requests we have to get the current user from the menu_item_rating param
    if (!current_user || current_user.nil?)
      user = @menu_item_rating.user
    else
      user = current_user
    end
  
    auth = Authorization.find(:first, 
      :conditions => {:user_id => user.id, :provider => 'foursquare'})
    
    if (!auth || auth.token.empty?)
      return
    end
    
    menu_item_id = params[:menu_item_rating][:menu_item_id]
    menu_item = MenuItem.find_by_id(menu_item_id)
    
    foursquare_venue_id = menu_item.restaurant.foursquare_venue_id
    
    if (foursquare_venue_id.blank?)
      return
    end
    
    menu_item_friendly_id = menu_item.friendly_id
    name = menu_item.name
    
    menu_item_rating_id = @menu_item_rating.id.to_s
    link = "http://getcrave.com/items/"+menu_item_friendly_id+"#"+menu_item_rating_id
    
    review = "Check out my review of the " + name + " on crave - " + link
    
    client = Foursquare2::Client.new(:oauth_token => auth.token,
      :ssl => { :verify => OpenSSL::SSL::VERIFY_PEER, :ca_file => '/usr/lib/ssl/certs/ca-certificates.crt' })

    client.add_tip(:venueId => foursquare_venue_id, :text => review, :url => link)
  end

  # POST /menu_item_ratings
  # POST /menu_item_ratings.xml
  def create
      @menu_item_rating = MenuItemRating.new(params[:menu_item_rating])

      if current_user
        @menu_item_rating.user_id = current_user.id
      end

      respond_to { |format|
        if @menu_item_rating.save
          
          if (params[:facebook] == "yes")
            send_to_fb_wall
          end
          
          if (params[:twitter] == "yes")
            send_to_twitter
          end

          if (params[:foursquare] == "yes")
           send_to_foursquare
         end
          
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
            message = "Thanks for your review, "+ current_user.user_name+"!"
            render :js => "window.add_review(#{params[:menu_item_rating][:menu_item_id]},'#{message}')"
            current_user
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
