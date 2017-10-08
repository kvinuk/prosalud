require 'rails_helper'

RSpec.describe ConsultingRoom, type: :model do
  let(:consulting_room) { FactoryGirl.create(:consulting_room) }
  subject {consulting_room}

  it { should have_many(:client_appointments) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:room_type) }
  it { should validate_uniqueness_of(:name) }

  context "Availability validations" do
    context "instance method validations" do
      it 'checks if the room is available at 14:00 tomorrow when there is a meeting at 13:30' do
        consulting_room = FactoryGirl.create :consulting_room
        client_appointment = FactoryGirl.build :client_appointment_without_room
        client_appointment.consulting_room = consulting_room
        client_appointment.date = Date.tomorrow + 13.hours + 30.minutes
        client_appointment.save!
        expect(consulting_room.available_at?(Date.tomorrow + 14.hours)).to be false
      end

      it 'checks if the room is available at 14:00 tomorrow 
          when there is a meeting at 13:00 and another at 14:30' do
        consulting_room = FactoryGirl.create :consulting_room
        client_appointment = FactoryGirl.build :client_appointment_without_room
        client_appointment.consulting_room = consulting_room
        client_appointment.date = Date.tomorrow + 13.hours
        client_appointment.save
        client_appointment = FactoryGirl.build :client_appointment_without_room
        client_appointment.consulting_room = consulting_room
        client_appointment.date = Date.tomorrow + 14.hours + 30.minutes
        client_appointment.save
        expect(consulting_room.available_at?(Date.tomorrow + 14.hours)).to be false
      end

      it 'checks if the room is available at 14:00 tomorrow when there is no meetings' do
        consulting_room = FactoryGirl.create :consulting_room
        expect(consulting_room.available_at?(Date.tomorrow + 14.hours)).to be true
      end
    end

    context "class method validations" do
      it 'returns the rooms available at 14:00 tomorrow when there is a meeting at 13:30 in one of two rooms' do
        consulting_room = FactoryGirl.create :consulting_room
        client_appointment = FactoryGirl.build :client_appointment_without_room
        client_appointment.consulting_room = consulting_room
        client_appointment.date = Date.tomorrow + 13.hours + 30.minutes
        client_appointment.save!
        FactoryGirl.create :consulting_room
        expect(ConsultingRoom.available_rooms(Date.tomorrow + 14.hours).count).to be 1
      end

      it 'returns the rooms available at 14:00 tomorrow when there is a meeting at 13:30 in two of two rooms' do
        consulting_room = FactoryGirl.create :consulting_room
        client_appointment = FactoryGirl.build :client_appointment_without_room
        client_appointment.consulting_room = consulting_room
        client_appointment.date = Date.tomorrow + 13.hours + 30.minutes
        client_appointment.save!
        consulting_room = FactoryGirl.create :consulting_room
        client_appointment = FactoryGirl.build :client_appointment_without_room
        client_appointment.consulting_room = consulting_room
        client_appointment.date = Date.tomorrow + 13.hours + 30.minutes
        client_appointment.save!
        expect(ConsultingRoom.available_rooms(Date.tomorrow + 14.hours).count).to be 0
      end

      it 'return the rooms available at 14:00 tomorrow when there are no meetings in three of three rooms' do
        3.times do
          FactoryGirl.create :consulting_room
        end
        expect(ConsultingRoom.available_rooms(Date.tomorrow + 14.hours).count).to be 3
      end

    end

  end
end
