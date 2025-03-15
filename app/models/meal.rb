# frozen_string_literal: true

# Meal class definition
class Meal < ActiveRecord::Base

  belongs_to :user 
  has_many :consumptions
  has_many :consumers, through: :consumptions, source: :user

  belongs_to :user

  validates :name, presence: true

  validates :calories, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :protein, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :lipide, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :glucide, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :default_meals, -> { where(is_default: true) }
  scope :user_meals, ->(user_id) { where(user_id: user_id) } 

end