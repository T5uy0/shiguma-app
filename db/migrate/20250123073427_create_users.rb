# frozen_string_literal: true

# Class to create a new user
class CreateUsers < ActiveRecord::Migration[8.0]
  def change
      create_table :users do |u|
        u.string :name, null: false
        u.string :email, null: false
        u.string :password_digest, null: false
        u.timestamps
      end
      add_index :users, :email, unique: true

  end
end
