class AddPriceToClientAppointment < ActiveRecord::Migration[5.0]
  def change
    add_column :client_appointments, :price, :float
  end
end
