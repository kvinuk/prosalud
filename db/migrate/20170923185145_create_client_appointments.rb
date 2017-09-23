class CreateClientAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :client_appointments do |t|
      t.datetime :date
      t.string :status
      t.text :comments
      t.references :client, foreign_key: true
      t.references :therapist, foreign_key: true

      t.timestamps
    end
  end
end
