class Position < ApplicationRecord
  include Searchable

  has_many :user_position_assignments, dependent: :destroy
  has_many :users, through: :user_position_assignments

  validates :name, presence: true, uniqueness: true

  def self.search(query)
    search_with_fields(query, {
      name: :string,
      description: :string,
      created_at: :datetime,
      updated_at: :datetime
    })
  end
end
