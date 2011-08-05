class UserVoteCitiesController < ApplicationController
  # GET /user_vote_cities
  # GET /user_vote_cities.xml
  def index
    @user_vote_cities = UserVoteCity.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_vote_cities }
      format.json  { render :json => @user_vote_cities }
    end
  end

  # GET /user_vote_cities/1
  # GET /user_vote_cities/1.xml
  def show
    @user_vote_city = UserVoteCity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_vote_city }
      format.json  { render :json => @user_vote_city }
    end
  end

  # GET /user_vote_cities/new
  # GET /user_vote_cities/new.xml
  def new
    @user_vote_city = UserVoteCity.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_vote_city }
      format.json  { render :json => @user_vote_city }
    end
  end

  # GET /user_vote_cities/1/edit
  def edit
    @user_vote_city = UserVoteCity.find(params[:id])
  end

  # POST /user_vote_cities
  # POST /user_vote_cities.xml
  def create
    @user_vote_city = UserVoteCity.new(params[:user_vote_city])

    respond_to do |format|
      if @user_vote_city.save
        format.html { redirect_to(@user_vote_city, :notice => 'User vote city was successfully created.') }
        format.xml  { render :xml => @user_vote_city, :status => :created, :location => @user_vote_city }
        format.json  { render :json => @user_vote_city, :status => :created, :location => @user_vote_city }        
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_vote_city.errors, :status => :unprocessable_entity }
        format.json  { render :json => @user_vote_city.errors, :status => :unprocessable_entity }        
      end
    end
  end

  # PUT /user_vote_cities/1
  # PUT /user_vote_cities/1.xml
  def update
    @user_vote_city = UserVoteCity.find(params[:id])

    respond_to do |format|
      if @user_vote_city.update_attributes(params[:user_vote_city])
        format.html { redirect_to(@user_vote_city, :notice => 'User vote city was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :json }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_vote_city.errors, :status => :unprocessable_entity }
        format.json  { render :json => @user_vote_city.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_vote_cities/1
  # DELETE /user_vote_cities/1.xml
  def destroy
    @user_vote_city = UserVoteCity.find(params[:id])
    @user_vote_city.destroy

    respond_to do |format|
      format.html { redirect_to(user_vote_cities_url) }
      format.xml  { head :ok }
      format.json  { head :ok }      
    end
  end
end
