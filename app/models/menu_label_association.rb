class MenuLabelAssociation < ActiveRecord::Base
  belongs_to :menu_item
  belongs_to :menu_label
  validates_uniqueness_of :menu_item_id, :scope => [:menu_label_id, :user_id]
  validates_presence_of :menu_item_id, :menu_label_id, :user_id
end
