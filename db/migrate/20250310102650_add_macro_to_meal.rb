class AddMacroToMeal < ActiveRecord::Migration[8.0]
  def change
    add_column :meals, :protein, :integer, null: true, default: nil
    add_column :meals, :lipide, :integer, null: true, default: nil
    add_column :meals, :glucide, :integer, null: true, default: nil
  end
end
