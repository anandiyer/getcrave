class CreateMenuLabels < ActiveRecord::Migration
  def self.up
    create_table :menu_labels do |t|
      t.string :menu_label

      t.timestamps
    end
  end

  def self.down
    drop_table :menu_labels
  end
end
