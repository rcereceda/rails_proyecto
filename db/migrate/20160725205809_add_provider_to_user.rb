class AddProviderToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_provider, :boolean
  end
end
