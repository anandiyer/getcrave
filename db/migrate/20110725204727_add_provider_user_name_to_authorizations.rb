class AddProviderUserNameToAuthorizations < ActiveRecord::Migration
  def self.up
    add_column :authorizations, :provider_user_name, :string
  end

  def self.down
    remove_column :authorizations, :provider_user_name
  end
end
