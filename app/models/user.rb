# frozen_string_literal: true

# User class definition
class User < ActiveRecord::Base
  has_secure_password
  has_many foreign_key: 'user_id'

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end