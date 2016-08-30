class RemoveStateFromOrder < ActiveRecord::Migration
  def change
    remove_reference :orders, :state, index: true, foreign_key: true
  end
end
