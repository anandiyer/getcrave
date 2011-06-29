class AlphaTestersController < ApplicationController
  # GET /alpha_testers
  # GET /alpha_testers.xml
  def index
    @alpha_testers = AlphaTester.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @alpha_testers }
    end
  end

  # GET /alpha_testers/1
  # GET /alpha_testers/1.xml
  def show
    @alpha_tester = AlphaTester.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @alpha_tester }
    end
  end

  # GET /alpha_testers/new
  # GET /alpha_testers/new.xml
  def new
    @alpha_tester = AlphaTester.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @alpha_tester }
    end
  end

  # GET /alpha_testers/1/edit
  def edit
    @alpha_tester = AlphaTester.find(params[:id])
  end

  # POST /alpha_testers
  # POST /alpha_testers.xml
  def create
    @alpha_tester = AlphaTester.new(params[:alpha_tester])

    respond_to do |format|
      if @alpha_tester.save
        format.html { redirect_to(@alpha_tester, :notice => 'Alpha tester was successfully created.') }
        format.xml  { render :xml => @alpha_tester, :status => :created, :location => @alpha_tester }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @alpha_tester.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /alpha_testers/1
  # PUT /alpha_testers/1.xml
  def update
    @alpha_tester = AlphaTester.find(params[:id])

    respond_to do |format|
      if @alpha_tester.update_attributes(params[:alpha_tester])
        format.html { redirect_to(@alpha_tester, :notice => 'Alpha tester was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @alpha_tester.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /alpha_testers/1
  # DELETE /alpha_testers/1.xml
  def destroy
    @alpha_tester = AlphaTester.find(params[:id])
    @alpha_tester.destroy

    respond_to do |format|
      format.html { redirect_to(alpha_testers_url) }
      format.xml  { head :ok }
    end
  end
end
