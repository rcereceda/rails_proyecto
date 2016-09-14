class ChangeDatesToTime < ActiveRecord::Migration
  def change
    change_column :schedules, :starttime, :time
    change_column :schedules, :endtime, :time
  end
end
