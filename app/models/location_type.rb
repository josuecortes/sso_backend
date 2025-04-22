class LocationType < ApplicationRecord
  has_many :organizational_units

  validates :name, presence: true
  validates_uniqueness_of :name
end
