# frozen_string_literal: true

# Mass class definition
class Mass < ActiveRecord::Base

  belongs_to :user 

  validates :mass, presence: true, numericality: { greater_than: 0 }
end