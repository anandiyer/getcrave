class MenuItemPhotosController < ApplicationController




  # GET /menu_item_photos
  # GET /menu_item_photos.xml
  def index
    @menu_item_photos = MenuItemPhoto.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @menu_item_photos }
    end
  end

  # GET /menu_item_photos/1
  # GET /menu_item_photos/1.xml
  def show
    @menu_item_photo = MenuItemPhoto.find(params[:id])

    respond_to do |format|
      format.html # _unused_show.html.haml
      format.xml  { render :xml => @menu_item_photo }
    end
  end

  # GET /menu_item_photos/new
  # GET /menu_item_photos/new.xml
  def new
    @menu_item_photo = MenuItemPhoto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @menu_item_photo }
    end
  end

  # GET /menu_item_photos/1/edit
  def edit
    @menu_item_photo = MenuItemPhoto.find(params[:id])
  end

  # POST /menu_item_photos
  # POST /menu_item_photos.xml
#  def create
#    @menu_item_photo = MenuItemPhoto.new(params[:menu_item_photo])
#
#    respond_to do |format|
#      if @menu_item_photo.save
#        format.html { redirect_to(@menu_item_photo, :notice => 'Menu item photo was successfully created.') }
#        format.xml  { render :xml => @menu_item_photo, :status => :created, :location => @menu_item_photo }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @menu_item_photo.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

  def create
    fileUp = params[:upload]
    orig_filename = fileUp['datafile'].original_filename


#    filename = sanitize_filename(orig_filename)
    filename = orig_filename

    AWS::S3::S3Object.store(filename, fileUp['datafile'].read, BUCKET, :access => :public_read)
    url = AWS::S3::S3Object.url_for(filename, BUCKET, :authenticated => false)

    p "******************************************************"
    p url
    p "******************************************************"

#    @image = Image.new(params[:image])
#    @image.user = current_user
#    @image.filename = filename
#    @image.url = url;
#    if @image.save
#      flash[:success] = "Image saved! "
#      render '/home'
#    else
#      render '/users/new_image'
#    end
  end


  # PUT /menu_item_photos/1
  # PUT /menu_item_photos/1.xml
  def update
    @menu_item_photo = MenuItemPhoto.find(params[:id])

    respond_to do |format|
      if @menu_item_photo.update_attributes(params[:menu_item_photo])
        format.html { redirect_to(@menu_item_photo, :notice => 'Menu item photo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menu_item_photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_item_photos/1
  # DELETE /menu_item_photos/1.xml
  def destroy
    @menu_item_photo = MenuItemPhoto.find(params[:id])
    @menu_item_photo.destroy

    respond_to do |format|
      format.html { redirect_to(menu_item_photos_url) }
      format.xml  { head :ok }
    end
  end
end
