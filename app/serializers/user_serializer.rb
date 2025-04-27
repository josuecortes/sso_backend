#


class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :email, :cpf, :matricula, :birth_date, :phone, :whatsapp, :position_type, :position_id, :active, :created_at, :updated_at

  attribute :active_roles do |user|
    user.user_role_assignments.includes(:role).where(active: true).map do |assignment|
      {
        id: assignment.role.id,
        name: assignment.role.name,
        assigned_at: assignment.created_at
      }
    end
  end

  attribute :active_positions do |user|
    user.user_position_assignments.includes(:position, :organizational_unit).where(active: true).map do |assignment|
      {
        id: assignment.id,
        position_name: assignment.position&.name,
        organizational_unit_name: assignment.organizational_unit&.name,
        assigned_at: assignment.created_at
      }
    end
  end
end
