class AddInstitutionToClient < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :institution, :string
  end
end
