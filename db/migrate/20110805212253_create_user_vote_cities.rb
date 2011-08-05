class CreateUserVoteCities < ActiveRecord::Migration
  def self.up
    create_table :user_vote_cities do |t|
      t.string :email
      t.string :city
      t.string :state
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end

  def self.down
    drop_table :user_vote_cities
  end
end
