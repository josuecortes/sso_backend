class UserPositionAssignmentPolicy < ApplicationPolicy
  def index?
    user.has_active_role?("administrador") || user.has_active_role?("master")
  end

  def create?
    index?
  end

  def destroy?
    index?
  end
end
