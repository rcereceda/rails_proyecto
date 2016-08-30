class AddProviderToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :provider, index: true
    add_foreign_key :orders, :users, column: :provider_id
  end
end