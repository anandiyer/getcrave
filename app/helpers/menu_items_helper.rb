module MenuItemsHelper

#  menu_item_id - related menu item id
  def is_item_saved? menu_item_id
    UserSavedMenuItem.where(:user_id => current_user.id, :menu_item_id => menu_item_id).exists? if current_user
  end


#  menu_item_id - menu_item_id for count
  def photos_count menu_item_id
    MenuItem.find(menu_item_id).menu_item_photos.count.to_s
  end

def get_photo_url_4_thumbnail menu_item_id, size = "middle"
  if MenuItem.find(menu_item_id).menu_item_photos.any?
    MenuItem.find(menu_item_id).menu_item_photos.first.photo
  else
    size == "middle" ? "temp_image.png" : "item_rest_temp_image.png"
  end
end

# menu_item_id - menu_item_id 2 get photos

  def get_photos menu_item_id
    MenuItem.find(menu_item_id).menu_item_photos.map{|x| x.photo}
  end


end
