class UserSavedMenuItem < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :menu_item
  validates_uniqueness_of :menu_item_id, :scope => :user_id, :message => "this item has already been saved"
end
