class AddColumnsToClientAppointment < ActiveRecord::Migration[5.0]
  def change
    add_reference :client_appointments, :treatment, foreign_key: true
    add_reference :client_appointments, :service, foreign_key: true
  end
end
