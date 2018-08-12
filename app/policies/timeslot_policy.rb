class TimeslotPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    user.host
  end

  def update?
    user.host && (user == record.experience.user)
  end

  def destroy?
    user.host && (user == record.experience.user)
  end
end
