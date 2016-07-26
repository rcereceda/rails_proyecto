class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.datetime :starttime
      t.datetime :endtime
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
