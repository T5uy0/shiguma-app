class AddIsDefaultMeal < ActiveRecord::Migration[8.0]
  def change
    add_column :meals, :is_default, :boolean, null: false, default: false
  end
end
