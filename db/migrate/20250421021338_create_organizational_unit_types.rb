class CreateOrganizationalUnitTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :organizational_unit_types do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
