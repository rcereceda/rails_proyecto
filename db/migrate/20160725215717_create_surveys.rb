class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.integer :stars
      t.text :comments
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
