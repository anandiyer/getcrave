module MenuItemsHelper
  def is_item_saved? menu_item_id
    UserSavedMenuItem.where(:user_id => current_user.id, :menu_item_id => menu_item_id).exists?
  end
end
