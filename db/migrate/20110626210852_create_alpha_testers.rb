class CreateAlphaTesters < ActiveRecord::Migration
  def self.up
    create_table :alpha_testers do |t|
      t.integer :facebook_id
      t.boolean :authorized

      t.timestamps
    end
  end

  def self.down
    drop_table :alpha_testers
  end
end
