class Schedule < ApplicationRecord
  belongs_to :therapist
  validates :start_time, :end_time, :week_day, presence: true
  validates_time :start_time, :end_time
  validates_time :start_time, on_or_after: '7:00 am',
                              on_or_after_message: 'Debe ser despues del horario de apertura'
  validates_time :end_time, on_or_before: '7:00 pm',
                            on_or_before_message: 'Debe ser antes de cerrar'
  validates_time :end_time, after: :start_time,
                            after_message: 'Debe empezar antes que el tiempo de inicio'

  def self.work_days
    %w[Lunes Martes Miércoles Jueves Viernes]
  end

  def day_of_week
    case week_day
    when "Lunes"
      1
    when "Martes"
      2
    when "Miércoles"
      3
    when "Jueves"
      4
    when "Viernes"
      5
    end
  end
end
