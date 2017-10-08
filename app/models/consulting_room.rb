class ConsultingRoom < ApplicationRecord
  has_many :client_appointments

  validates :name, :room_type, presence: true
  validates :name, uniqueness: true

  def self.available_rooms(reservation_date)
    all.select{ |room| room.available_at?(reservation_date) }
  end

  def available_at?(reservation_date)
    duration = 1.hours
    datetime_range = (reservation_date - duration)...(reservation_date + duration)
    client_appointments.where(date: datetime_range).each do |appointment|
      appointment_datetime = appointment.date
      return false if reservation_check(reservation_date, appointment_datetime, duration)
    end
    true
  end

  private

  def reservation_check(reservation_date, appointment_datetime, duration)
    appoinment_end_time = appointment_datetime + duration - 1.seconds
    reservation_end_time = reservation_date + duration
    start_check = reservation_date.between?(appointment_datetime, appoinment_end_time)
    end_check = reservation_end_time.between?(appointment_datetime, appoinment_end_time)
    start_check || end_check ? true : false
  end
end
