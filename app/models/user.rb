class User < ApplicationRecord
  # Inclui a estratégia de revogação por JTI
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Devise modules
  devise :database_authenticatable,
         :registerable,
         :jwt_authenticatable,
         :validatable,
         jwt_revocation_strategy: self

  has_many :user_role_assignments, dependent: :destroy
  has_many :roles, through: :user_role_assignments       

  # Garantir que o jti seja gerado antes de salvar
  before_create :generate_jti

  validates_presence_of :name, :email
  validates :cpf, uniqueness: true, if: :should_validate_cpf?
  
  def has_role?(role_name)
    roles.where(name: role_name).any?
  end

  def has_active_role?(role_name)
    user_role_assignments.joins(:role).where(roles: { name: role_name }, active: true).exists?
  end
  
  private

  def generate_jti
    self.jti ||= SecureRandom.uuid
  end

  def should_validate_cpf?
    cpf.present? && !cpf.strip.empty?
  end

end
