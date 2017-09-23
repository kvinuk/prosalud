class CreateTreatments < ActiveRecord::Migration[5.0]
  def change
    create_table :treatments do |t|
      t.date :start_date
      t.date :end_date
      t.references :client, foreign_key: true
      t.references :therapist, foreign_key: true
      t.references :service, foreign_key: true

      t.timestamps
    end
  end
end
