require 'twiliolib'

class FoursquareCheckinsController < ApplicationController
  # GET /foursquare_checkins
  # GET /foursquare_checkins.xml
  def index
    @foursquare_checkins = FoursquareCheckin.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @foursquare_checkins }
    end
  end

  # GET /foursquare_checkins/1
  # GET /foursquare_checkins/1.xml
  def show
    @foursquare_checkin = FoursquareCheckin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @foursquare_checkin }
    end
  end

  # GET /foursquare_checkins/new
  # GET /foursquare_checkins/new.xml
  def new
    @foursquare_checkin = FoursquareCheckin.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @foursquare_checkin }
    end
  end

  # GET /foursquare_checkins/1/edit
  def edit
    @foursquare_checkin = FoursquareCheckin.find(params[:id])
  end

  # POST /foursquare_checkins
  # POST /foursquare_checkins.xml
  def create
    
    posted_json = request.body.read
    
    pj = JSON.parse(posted_json)
    p pj
    
    @checkin = FoursquareCheckin.new()
#    @checkin.data = posted_json
    
    if (pj["checkin"])
      @checkin.checkin_id = pj["checkin"]["id"]
      if (pj["checkin"]["venue"])
        @checkin.venue_id = pj["checkin"]["venue"]["id"]
      end
    end
    if (pj["user"])
      @checkin.user_id = pj["user"]["id"]
    end
    
    @checkin.save
    
    # Get the top item at this foursquare venue
    @foursquare_venue_id = @checkin.venue_id
    @conditions = "restaurants.foursquare_venue_id = \'#{@foursquare_venue_id}\'"
    
    @menu_item = MenuItem.find(:first, 
      :conditions => @conditions, 
      :joins => " INNER JOIN restaurants ON restaurants.id = menu_items.restaurant_ID LEFT OUTER JOIN menu_item_avg_rating_count ON menu_item_avg_rating_count.menu_item_id = menu_items.id",
      :order => "(menu_item_avg_rating_count.avg_rating IS NULL) ASC, menu_item_avg_rating_count.avg_rating DESC, menu_item_avg_rating_count.count DESC",
      :include => :restaurant)
      
    p "DEBUGGING"
    p @menu_item
    
    if (@menu_item)    
      @body = "While you're at " + @menu_item.restaurant.name + " try the " + @menu_item.name +
        ". " + "http://getcrave.com/items/" + @menu_item.id.to_s
    
      # Get the user we should be sending this to
      @provider = "foursquare"
      @uid = @checkin.user_id
      @conditions = "provider = \'#{@provider}\' AND uid = \'#{@uid}\'"
      @auth = Authorization.find(:first, :conditions => @conditions)

      # If we have this user's phone number saved, send them a text
      if @auth && @auth.user.telephone
        @phone = @auth.user.telephone

        # SMS
        # Create a Twilio REST account object using your Twilio account ID and token
        account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
    
        t = {
            'From' => CALLER_ID,
            'To'   => @phone,
            'Body' => @body
        }
        resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages",
            "POST", t)
          
        p "response"
        p resp.code
        p resp.body
      end
    end

    respond_to do |format|
        format.html { redirect_to(@checkin, :notice => 'Checkin was successfully created.') }
        format.xml  { render :xml => @checkin, :status => :created, :location => @checkin }
        format.json  { render :json => @checkin, :status => :created, :location => @checkin }
    end    
  end

  # PUT /foursquare_checkins/1
  # PUT /foursquare_checkins/1.xml
  def update
    @foursquare_checkin = FoursquareCheckin.find(params[:id])

    respond_to do |format|
      if @foursquare_checkin.update_attributes(params[:foursquare_checkin])
        format.html { redirect_to(@foursquare_checkin, :notice => 'Foursquare checkin was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @foursquare_checkin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /foursquare_checkins/1
  # DELETE /foursquare_checkins/1.xml
  def destroy
    @foursquare_checkin = FoursquareCheckin.find(params[:id])
    @foursquare_checkin.destroy

    respond_to do |format|
      format.html { redirect_to(foursquare_checkins_url) }
      format.xml  { head :ok }
    end
  end
end