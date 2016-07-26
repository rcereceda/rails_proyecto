class CreateUserServices < ActiveRecord::Migration
  def change
    create_table :user_services do |t|
      t.references :user, index: true, foreign_key: true
      t.references :service, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
