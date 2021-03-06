class ClientAppointment < ApplicationRecord
  belongs_to :client
  belongs_to :therapist
  belongs_to :consulting_room
  belongs_to :service, optional: true
  has_one :appointment_report, dependent: :destroy
  validates :status, :client, :therapist, :date, :treatment, presence: true
  validates_numericality_of :price

  validates_date :date, on_or_after: :today,
                        on_or_after_message: 'date must be after today'



  def client_name
    client.fname + " " + client.lname
  end

  def appointment_type
    therapist.therapist_type
  end

  def self.status
    %w[Pendiente Finalizada]
  end

  before_validation do
    self.price = service.price(client) if !price
  end


end
