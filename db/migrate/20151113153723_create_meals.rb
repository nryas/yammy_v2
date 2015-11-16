class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.date :date
      t.string :period
      t.integer :energy
      t.integer :protein
      t.integer :fat
      t.integer :carbohydrate
      t.float :salt

      t.timestamps null: false
    end
  end
end
