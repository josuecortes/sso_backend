class Role < ApplicationRecord
  include Searchable

  has_many :user_role_assignments, dependent: :destroy
  has_many :users, through: :user_role_assignments

  validates :name, presence: true, uniqueness: true

  before_destroy :check_if_can_be_destroyed

  PROTECTED_ROLES = %w[master administrador normal].freeze

  def self.search(query)
    search_with_fields(query, {
      name: :string,
      description: :string,
      created_at: :datetime,
      updated_at: :datetime
    })
  end

  def check_if_can_be_destroyed
    if PROTECTED_ROLES.include?(name.downcase)
      errors.add(:base, "A role '#{name}' não pode ser deletada pois é uma role protegida do sistema.")
      throw(:abort)
    elsif user_role_assignments.any?
      errors.add(:base, "A role '#{name}' não pode ser deletada pois está associada a usuários.")
      throw(:abort)
    end
  end
end
