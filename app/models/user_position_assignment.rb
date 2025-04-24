class UserPositionAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :position
  belongs_to :organizational_unit

  validates :active, inclusion: { in: [ true, false ] }

  validates :position_id, uniqueness: { scope: [ :user_id, :active ], message: "already active for this user" }, if: -> { active? }
end
