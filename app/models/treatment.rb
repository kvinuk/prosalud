class Treatment < ApplicationRecord
  belongs_to :client
  belongs_to :therapist
  has_many :client_appointments

  validates :start_date, :end_date, :client, :therapist, presence: true

  validates_date :start_date, before: :end_date,
                              before_message: 'La fecha debe ser antes de la fecha de terminación'
  validates_date :end_date, after: :start_date,
                            after_message: 'La fecha debe ser después de la fecha de inicio'
end