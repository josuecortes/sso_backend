class AddProfileFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string
    add_column :users, :birth_date, :date
    add_column :users, :phone, :string
    add_column :users, :whatsapp, :string
    add_column :users, :cpf, :string
    add_column :users, :matricula, :string
  end
end
