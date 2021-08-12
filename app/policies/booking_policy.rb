class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    # to change
    true
  end

  def create?
    record.service.user != user
  end

  def update?
    record.service.user == user
  end

  def destroy?
    record.user == user
  end
end
