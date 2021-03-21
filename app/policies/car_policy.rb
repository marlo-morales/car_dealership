# frozen_string_literal: true

class CarPolicy < ApplicationPolicy
  def create?
    user.present? || super
  end

  def update?
    record.seller == user || super
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
