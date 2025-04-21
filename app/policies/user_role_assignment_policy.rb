class UserRoleAssignmentPolicy < ApplicationPolicy
  def index?
    user.has_active_role?("administrador") || user.has_active_role?("master")
  end

  def create?
    if record.role.name == "master"
      user.has_active_role?("master")
    else
      user.has_active_role?("administrador") || user.has_active_role?("master")
    end
  end

  def destroy?
    if record.role.name == "master"
      user.has_active_role?("master")
    else
      user.has_active_role?("administrador") || user.has_active_role?("master")
    end
  end
end
