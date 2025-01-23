# frozen_string_literal: true

# Meal class definition
class Meal < ActiveRecord::Base

  belongs_to :user 
  has_many :consumptions
  has_many :consumers, through: :consumptions, source: :user
end