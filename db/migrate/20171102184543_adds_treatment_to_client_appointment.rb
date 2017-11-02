class AddsTreatmentToClientAppointment < ActiveRecord::Migration[5.0]
  def change
    add_column :client_appointments, :treatment, :string
  end
end
