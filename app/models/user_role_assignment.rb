class UserRoleAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :role
  belongs_to :assigned_by, class_name: "User", optional: true

  # Garante que active seja true ou false (nunca nil)
  validates :active, inclusion: { in: [ true, false ] }

  validates :role_id, uniqueness: { scope: [ :user_id, :active ], message: "already active for this user" }, if: -> { active? }

  validate :only_one_active_admin_role, if: -> { active? && role&.name == "administrador" }

  def only_one_active_admin_role
    if UserRoleAssignment.where(user_id: user_id, active: true).joins(:role).where(roles: { name: "administrador" }).exists?
      errors.add(:base, "User already has an active Administrador role")
    end
  end
end
