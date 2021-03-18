# frozen_string_literal: true

class Car < ApplicationRecord
  belongs_to :seller, class_name: "User", foreign_key: :seller_id, validate: true

  validates_presence_of :make, :model, :year
  validates_numericality_of :year, greater_than_or_equal_to: 1900
  validates_uniqueness_of :model, scope: %i(make year condition price seller_id)
  validates_inclusion_of :condition, in: :conditions
  validates_numericality_of :price, greater_than_or_equal_to: 1_000, less_than_or_equal_to: 100_000

  enum condition: { poor: 0, fair: 1, good: 2, excellent: 3 }

  private

  def conditions
    Car.conditions
  end
end
