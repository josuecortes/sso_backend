class RolePolicy < ApplicationPolicy
  def index?
    user.has_active_role?("administrador") || user.has_active_role?("master")
  end

  def show?
    index?
  end

  def create?
    user.has_active_role?("master")
  end

  def update?
    return false if record.name == "master" && !user.has_active_role?("master")
    user.has_active_role?("administrador") || user.has_active_role?("master")
  end

  def destroy?
    user.has_active_role?("master")
  end
end
