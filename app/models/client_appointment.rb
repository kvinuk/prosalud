class ClientAppointment < ApplicationRecord
  belongs_to :client
  belongs_to :therapist
  validates :status, :client, :therapist, :date , presence: true

	def self.status
		["Pendiente", "Finalizada"]
	end
end
