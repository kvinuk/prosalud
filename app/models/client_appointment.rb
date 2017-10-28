class ClientAppointment < ApplicationRecord
  belongs_to :client
  belongs_to :therapist
  belongs_to :consulting_room
  belongs_to :service, optional: true
  belongs_to :treatment, optional: true
  validates :status, :client, :therapist, :date, presence: true
  validates_numericality_of :price

  validates_date :date, on_or_after: :today,
                        on_or_after_message: 'date must be after today'

  def self.status
    %w[Pendiente Finalizada]
  end

  before_validation do
    self.price = service.price(client) if !price
  end
end
