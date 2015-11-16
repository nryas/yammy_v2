class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.integer :meal_id
      t.integer :dish_id

      t.timestamps null: false
    end
  end
end
