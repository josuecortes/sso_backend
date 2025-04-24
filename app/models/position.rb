class Position < ApplicationRecord
  has_many :user_position_assignments, dependent: :destroy
  has_many :users, through: :user_position_assignments

  validates :name, presence: true, uniqueness: true

end
