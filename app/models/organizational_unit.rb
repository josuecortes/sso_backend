class OrganizationalUnit < ApplicationRecord
  belongs_to :organizational_unit_type
  belongs_to :location_type
  belongs_to :parent, class_name: 'OrganizationalUnit', optional: true
  has_many :children, class_name: 'OrganizationalUnit', foreign_key: :parent_id

  validates_presence_of :name, :location_type_id, :organizational_unit_type_id
  validates_uniqueness_of :name
  validates :active, inclusion: { in: [ true, false ] }
end