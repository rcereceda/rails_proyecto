class AddColumnsToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :active, :boolean
    add_column :schedules, :monday, :boolean
    add_column :schedules, :tuesday, :boolean
    add_column :schedules, :wednesday, :boolean
    add_column :schedules, :thursday, :boolean
    add_column :schedules, :friday, :boolean
    add_column :schedules, :saturday, :boolean
    add_column :schedules, :sunday, :boolean
  end
end
