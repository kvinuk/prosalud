class Schedule < ApplicationRecord

	validates :start_time, :end_time, :week_day, presence: true

	def self.work_days
		["Lunes", "Martes", "Miércoles", "Jueves", "Viernes"]
	end
end
