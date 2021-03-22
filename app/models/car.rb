# frozen_string_literal: true

class Car < ApplicationRecord
  COMMISSION_PERCENT = 0.05

  belongs_to :seller, class_name: "User", foreign_key: :seller_id, validate: true
  belongs_to :buyer, class_name: "User", foreign_key: :buyer_id, validate: :validate_buyer?, optional: -> { !validate_buyer? }

  validates_presence_of :make, :model, :year
  validates_numericality_of :year, greater_than_or_equal_to: 1900
  validates_uniqueness_of :model, scope: %i(make year condition price seller_id), message: :car_model_taken
  validates_inclusion_of :condition, in: :conditions
  validates_numericality_of :price, greater_than_or_equal_to: 1_000, less_than_or_equal_to: 100_000

  scope :recent, -> { order(created_at: :desc) }

  enum condition: { poor: 0, fair: 1, good: 2, excellent: 3 }

  attr_accessor :validate_buyer

  def title
    "#{make} #{model} (#{year})"
  end

  def sold?
    buyer_id.present?
  end

  def commission
    @commission ||= price * COMMISSION_PERCENT
  end

  def net_amount
    @net_amount ||= price - commission
  end

  def sent_sold_email?
    sent_sold_email_at.present?
  end

  def make_available
    self.buyer_id = nil
    self.sent_sold_email_at = nil
    save
  end

  private

  def conditions
    Car.conditions
  end

  def validate_buyer?
    validate_buyer.present?
  end
end
