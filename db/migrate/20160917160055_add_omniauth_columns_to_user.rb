class AddOmniauthColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :auth_provider, :string
  end
end
