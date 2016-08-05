class RenameSlotToSchedule < ActiveRecord::Migration
  def change
  	rename_table :slots, :schedules
  end
end
