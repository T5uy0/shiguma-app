class DropMealsTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :meals
  end
end
