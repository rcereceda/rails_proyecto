class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :date
      t.string :description
      t.text :information
      t.references :user, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true
      t.references :slot, index: true, foreign_key: true
      t.references :service, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
