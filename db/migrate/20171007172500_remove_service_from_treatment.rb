class RemoveServiceFromTreatment < ActiveRecord::Migration[5.0]
  def up
    remove_column :treatments, :service_id
  end

  def down
    add_column :treatments, :service_id, :integer, index: true
  end
end
