# frozen_string_literal: true

# Consumption class definition
class Consumption < ActiveRecord::Base

  belongs_to :user
  belongs_to :meal

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
