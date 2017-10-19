class AddConsultingRoomToClientAppointments < ActiveRecord::Migration[5.0]
  def change
    add_reference :client_appointments, :consulting_room, foreign_key: true
  end
end
