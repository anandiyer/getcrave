module MenuItemsHelper

#  menu_item_id - related menu item id
  def is_item_saved? menu_item_id
    UserSavedMenuItem.where(:user_id => current_user.id, :menu_item_id => menu_item_id).exists? if current_user
  end
end
