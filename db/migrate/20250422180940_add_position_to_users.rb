class AddPositionToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :position_type, :string
    add_reference :users, :position, null: true, foreign_key: true
  end
end
