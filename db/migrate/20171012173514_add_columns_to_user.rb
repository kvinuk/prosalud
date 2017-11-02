class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role_type, :string
  end
end
