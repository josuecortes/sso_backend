class CreateUserPositionAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :user_position_assignments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :position, null: false, foreign_key: true
      t.references :organizational_unit, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.boolean :active

      t.timestamps
    end
  end
end
