class AddTherapistToSchedule < ActiveRecord::Migration[5.0]
  def change
    add_reference :schedules, :therapist, foreign_key: true
  end
end
