class CreateConsuptions < ActiveRecord::Migration[8.0]
  def change
    create_table :consumptions do |t|
      t.references :user, foreign_key: true    # L'utilisateur qui a consommé le repas
      t.references :meal, foreign_key: true    # Le repas consommé
      t.integer :quantity, null: false, default: 1  # Quantité du repas consommé
      t.datetime :consumed_at, null: false     # Date et heure de la consommation
      t.timestamps
    end
  end
end
