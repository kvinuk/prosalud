class RolifyCreateReceptionists < ActiveRecord::Migration
  def change
    create_table(:receptionists) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_receptionists, :id => false) do |t|
      t.references :user
      t.references :receptionist
    end

    add_index(:receptionists, :name)
    add_index(:receptionists, [ :name, :resource_type, :resource_id ])
    add_index(:users_receptionists, [ :user_id, :receptionist_id ])
  end
end
