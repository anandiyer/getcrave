class CreateTempImages < ActiveRecord::Migration
  def self.up
    create_table :temp_images do |t|
      t.string :hash
      t.string :image_name

      t.timestamps
    end
  end

  def self.down
    drop_table :temp_images
  end
end
