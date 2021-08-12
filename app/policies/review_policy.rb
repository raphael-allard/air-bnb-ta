class ReviewPolicy < ApplicationPolicy
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
    record.booking.user == user
  end
end
