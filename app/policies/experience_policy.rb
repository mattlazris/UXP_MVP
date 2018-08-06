class ExperiencePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    user.host?
  end

  def update?
    record.user == user && user.host?
  end

  def destroy?
    record.user == user && user.host?
  end
end
