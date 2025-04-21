class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :email, :cpf, :active, :created_at, :updated_at

  # Inclui todos os vínculos com roles
  # has_many :user_role_assignments, if: Proc.new { |user| user.user_role_assignments.any? }

  # Alternativamente, para mostrar apenas as roles ativas diretamente:
  attribute :active_roles do |user|
    user.user_role_assignments.includes(:role).where(active: true).map do |assignment|
      {
        id: assignment.role.id,
        name: assignment.role.name,
        assigned_at: assignment.created_at
      }
    end
  end
end
