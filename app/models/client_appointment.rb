class ClientAppointment < ApplicationRecord
  belongs_to :client
  belongs_to :therapist
  belongs_to :service, optional: true
  belongs_to :treatment, optional: true
  validates :status, :client, :therapist, :date, presence: true

  validates_date :date, on_or_after: :today,
                        on_or_after_message: 'date must be after today'

  def self.status
    %w[Pendiente Finalizada]
  end
end
