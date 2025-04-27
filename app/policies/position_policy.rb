class PositionPolicy < ApplicationPolicy
  def index?
    user.has_active_role?("administrador") || user.has_active_role?("master")
  end

  def show?
    user.has_active_role?("administrador") || user.has_active_role?("master")
  end

  def create?
    user.has_active_role?("administrador") || user.has_active_role?("master")
  end

  def update?
    user.has_active_role?("administrador") || user.has_active_role?("master")
  end

  def destroy?
    user.has_active_role?("administrador") || user.has_active_role?("master")
  end
end
