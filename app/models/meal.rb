# frozen_string_literal: true

# Meal class definition
class Meal < ActiveRecord::Base

  belongs_to :user 
  has_many :consumptions
  has_many :consumers, through: :consumptions, source: :user

  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user_id, message: "Ce repas existe déjà pour cet utilisateur." }, if: :is_active?

  validates :calories, presence: true, numericality: { greater_than_or_equal_to: 0 }

end