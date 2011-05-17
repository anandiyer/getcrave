class MenuItemAvgRatingCount < ActiveRecord::Base
  belongs_to :menu_item
    set_table_name "menu_item_avg_rating_count"
end