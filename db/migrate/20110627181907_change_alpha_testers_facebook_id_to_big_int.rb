class ChangeAlphaTestersFacebookIdToBigInt < ActiveRecord::Migration
  def self.up
    change_column :alpha_testers, :facebook_id, :bigint
  end

  def self.down
    change_column :alpha_testers, :facebook_id, :int
    # raise ActiveRecord::IrreversibleMigration 
  end
end
