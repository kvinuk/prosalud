class CreateAppointmentReports < ActiveRecord::Migration[5.0]
  def change
    create_table :appointment_reports do |t|
      t.boolean :client_assistance
      t.boolean :therapist_assistance
      t.datetime :start_hour
      t.string :delay_responsible
      t.references :client_appointment, foreign_key: true

      t.timestamps
    end
  end
end
