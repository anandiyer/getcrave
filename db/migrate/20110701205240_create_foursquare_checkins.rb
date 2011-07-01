class CreateFoursquareCheckins < ActiveRecord::Migration
  def self.up
    create_table :foursquare_checkins do |t|
      t.string :venue_id
      t.integer :user_id
      t.string :checkin_id

      t.timestamps
    end
  end

  def self.down
    drop_table :foursquare_checkins
  end
end
