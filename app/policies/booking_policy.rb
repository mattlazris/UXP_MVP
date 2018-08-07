class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    user
  end

  def update?
    user && (user == record.experience.user || user == record.user)
  end

  def destroy?
    user
  end
end
