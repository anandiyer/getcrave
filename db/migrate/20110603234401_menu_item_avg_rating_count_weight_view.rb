class MenuItemAvgRatingCountWeightView < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      DROP VIEW menu_item_avg_rating_count;
      CREATE VIEW menu_item_avg_rating_count AS 
      SELECT menu_items.id AS menu_item_id, AVG("menu_item_ratings"."rating") AS avg_rating, COUNT(*) AS count, AVG("menu_item_ratings"."rating")*COUNT(*) AS weight
      FROM "menu_items"
      INNER JOIN "menu_item_ratings" on (menu_item_ratings.menu_item_id = menu_items.id)
      GROUP BY menu_items.id
    SQL
  end

  def self.down
    execute <<-SQL
      DROP VIEW menu_item_avg_rating_count;
      CREATE VIEW menu_item_avg_rating_count AS 
      SELECT menu_items.id AS menu_item_id, AVG("menu_item_ratings"."rating") AS avg_rating, COUNT(*) AS count
      FROM "menu_items"
      INNER JOIN "menu_item_ratings" on (menu_item_ratings.menu_item_id = menu_items.id)
      GROUP BY menu_items.id
    SQL
  end
end
