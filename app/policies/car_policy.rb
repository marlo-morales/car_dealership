# frozen_string_literal: true

class CarPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    owned? || super
  end

  def owned?
    record.seller == user
  end

  def destroy?
    admin?
  end

  def buy?
    admin? || !owned?
  end

  def sold?
    buy?
  end

  def thank_you?
    create? || owned? || record.seller.present?
  end

  def unsold?
    admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
