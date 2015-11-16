class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.integer :energy

      t.timestamps null: false
    end
  end
end
