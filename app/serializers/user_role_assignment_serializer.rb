class UserRoleAssignmentSerializer
  include JSONAPI::Serializer

  attributes :id, :active, :created_at, :updated_at

  belongs_to :role
  belongs_to :assigned_by, serializer: UserSerializer
end
