class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    # to change
    true
  end

  def update?
    record.service.user == user
  end

  def destroy?
    record.user == user
  end
end
