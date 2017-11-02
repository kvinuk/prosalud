class AddEventIdToClientAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :client_appointments, :event_id, :string
  end
end
