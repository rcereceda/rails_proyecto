class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
