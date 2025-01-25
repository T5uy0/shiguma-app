class AddColumnMeal < ActiveRecord::Migration[8.0]
  def change
    add_column :meals, :is_active, :boolean, null: false, default: true
  end
end
