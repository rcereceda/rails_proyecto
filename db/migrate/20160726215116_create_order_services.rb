class CreateOrderServices < ActiveRecord::Migration
  def change
    create_table :order_services do |t|
      t.references :order, index: true, foreign_key: true
      t.references :user_service, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
