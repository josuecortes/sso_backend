class OrganizationalUnitSerializer < ActiveModel::Serializer
  attributes :id, :name, :code, :sigla, :active, :custom_fields, :created_at, :updated_at

  belongs_to :organizational_unit_type
  belongs_to :location_type
  belongs_to :parent, serializer: OrganizationalUnitSerializer
end
