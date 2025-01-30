# frozen_string_literal: true

# User class definition
class User < ActiveRecord::Base
  has_secure_password

  has_many :meals
  has_many :consumptions
  has_many :masses 
  has_many :consumed_meals, through: :consumptions, source: :meal

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end