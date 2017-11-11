class AddTypeToTherapists < ActiveRecord::Migration[5.0]
  def change
    add_column :therapists, :therapist_type, :string
  end
end
