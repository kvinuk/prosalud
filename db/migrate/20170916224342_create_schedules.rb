class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.time :start_time
      t.time :end_time
      t.string :week_day

      t.timestamps
    end
  end
end
