class AppointmentReport < ApplicationRecord
  belongs_to :client_appointment

  validates :client_assistance, :therapist_assistance, :start_hour, 
            :delay_responsible, presence: true

  validates_time :start_hour, on_or_after: "7:00 am",
                              on_or_after_message: 'Debe ser despues del horario de la cita'
end
