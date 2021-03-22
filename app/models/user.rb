# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :cars, foreign_key: :seller_id, dependent: :destroy
  has_many :bought_cars, class_name: "Car", foreign_key: :buyer_id, dependent: :nullify

  validates_presence_of :username, :first_name, :mobile_number
  validates_uniqueness_of :username, scope: %i(first_name last_name)

  alias_attribute :email, :username

  def name
    "#{first_name} #{last_name}"
  end

  def self.find_or_build_by(attributes)
    name = attributes[:name]
    username = attributes[:email]&.strip
    username = name&.downcase&.remove(" ")&.strip if username.blank?
    first_name, last_name = name.split(" ")
    mobile_number = attributes[:mobile_number]&.strip
    User.find_or_initialize_by(username: username, first_name: first_name&.strip, mobile_number: mobile_number).tap do |user|
      user.last_name = last_name
      user.password = SecureRandom.hex(8)
    end
  end
end
