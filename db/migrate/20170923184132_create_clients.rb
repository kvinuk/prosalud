class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :fname
      t.string :lname
      t.string :folio
      t.string :street
      t.string :neighborhood
      t.string :city
      t.integer :zipcode
      t.string :house_phone
      t.string :mobile_phone
      t.integer :age
      t.string :tutor_name
      t.date :contact_date
      t.text :observations
      t.references :channel, foreign_key: true

      t.timestamps
    end
  end
end
