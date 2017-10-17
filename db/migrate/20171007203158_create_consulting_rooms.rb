class CreateConsultingRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :consulting_rooms do |t|
      t.string :name
      t.string :room_type

      t.timestamps
    end
  end
end
