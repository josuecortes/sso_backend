class CreateOrganizationalUnits < ActiveRecord::Migration[8.0]
  def change
    create_table :organizational_units do |t|
      t.string :name
      t.string :code
      t.string :sigla
      t.boolean :active

      t.references :parent, foreign_key: { to_table: :organizational_units }
      t.references :organizational_unit_type, null: false, foreign_key: true
      t.references :location_type, null: false, foreign_key: true

      t.jsonb :custom_fields

      t.timestamps
    end
  end
end
