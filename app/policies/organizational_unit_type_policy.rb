class OrganizationalUnitTypePolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    admin?
  end

  def create?
    admin?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  private

  def admin?
    user.has_active_role?("master") || user.has_active_role?("administrador")
  end
end
