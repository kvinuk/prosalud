require 'rails_helper'

RSpec.describe Schedule, type: :model do
  let(:schedule) {FactoryGirl.build(:schedule)}
  subject {schedule}

  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }
  it { should validate_presence_of(:week_day) }

  it "should validate start time is before end time" do 
    schedule = FactoryGirl.build(:schedule)
    schedule.start_time = "9:00 am"
    schedule.end_time = "8:00 am"
    schedule.save
    expect(schedule.errors.full_messages.first).to eq("End time Debe empezar antes que el tiempo de inicio")
  end

  it "should validate start time is after opening time" do 
    schedule = FactoryGirl.build(:schedule)
    schedule.start_time = schedule.start_time - (rand(5)+1).hours
    schedule.save
    expect(schedule.errors.full_messages.first).to eq("Start time Debe ser despues del horario de apertura")
  end

  it "should validate end time is before closing time" do 
    schedule = FactoryGirl.build(:schedule)
    schedule.end_time = schedule.end_time + (rand(3)+1).hours
    schedule.save
    expect(schedule.errors.full_messages.first).to eq("End time Debe ser antes de cerrar")
  end


end