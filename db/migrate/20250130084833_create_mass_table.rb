class CreateMassTable < ActiveRecord::Migration[8.0]
  def change
    create_table :masses do |t|
      t.references :user, foreign_key: true
      t.integer :mass, null: false
      t.timestamps
    end
  end
end