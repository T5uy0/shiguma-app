class CreateMealsTable < ActiveRecord::Migration[8.0]
  def change
    create_table :meals do |t|
      t.string :name, null: false
      t.integer :calories, null: false
      t.references :user, foreign_key: true 
      t.timestamps
    end
  end
end
