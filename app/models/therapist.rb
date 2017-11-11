class Therapist < ApplicationRecord
  belongs_to :user
  has_many :schedules
  has_many :client_appointments

  def self.available_therapists(reservation_date)
    all.select{ |room| room.available_at?(reservation_date) }
  end

  def available_at?(reservation_date)
    duration = 1.hours
    datetime_range = (reservation_date - duration)...(reservation_date + duration)
    client_appointments.where(date: datetime_range).each do |appointment|
      appointment_datetime = appointment.date
      return false if reservation_check(reservation_date, appointment_datetime, duration)
    end
    return false if !schedule_check(reservation_date)
    true
  end

  private

  def schedule_check(reservation_date)
    wday = reservation_date.wday
    day_schedules = schedules.select {|schedule| schedule.day_of_week == wday }
    day_schedules.each do |schedule|
      if reservation_date.hour.between?(schedule.start_time.hour, schedule.end_time.hour) && (reservation_date + 1.hours).hour.between?(schedule.start_time.hour, schedule.end_time.hour)
        return true
      end
    end
    false
  end

  def reservation_check(reservation_date, appointment_datetime, duration)
    appoinment_end_time = appointment_datetime + duration - 1.seconds
    reservation_end_time = reservation_date + duration
    start_check = reservation_date.between?(appointment_datetime, appoinment_end_time)
    end_check = reservation_end_time.between?(appointment_datetime, appoinment_end_time)
    start_check || end_check ? true : false
  end
end
