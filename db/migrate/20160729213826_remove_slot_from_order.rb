class RemoveSlotFromOrder < ActiveRecord::Migration
  def change
    remove_reference :orders, :slot, index: true, foreign_key: true
  end
end
