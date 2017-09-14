class RolifyCreateTherapists < ActiveRecord::Migration
  def change
    create_table(:therapists) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_therapists, :id => false) do |t|
      t.references :user
      t.references :therapist
    end

    add_index(:therapists, :name)
    add_index(:therapists, [ :name, :resource_type, :resource_id ])
    add_index(:users_therapists, [ :user_id, :therapist_id ])
  end
end
