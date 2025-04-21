class CreateUserRoleAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :user_role_assignments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true
      t.boolean :active
      t.references :assigned_by, foreign_key: { to_table: :users }
      t.datetime :assigned_at
      t.datetime :removed_at

      t.timestamps
    end
  end
end
