require 'rails_helper'

RSpec.describe Treatment, type: :model do
  let(:treatment) {FactoryGirl.build(:treatment)}
  subject {treatment}

  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should belong_to(:therapist) }
  it { should belong_to(:client) }
  it { should have_many(:client_appointments)}

  it "should validate start date is before end date" do 
    treatment = FactoryGirl.build(:treatment)
    treatment.start_date = "2017-10-20"
    treatment.end_date = "2017-08-20"
    treatment.save
    expect(treatment.errors.full_messages.include?("Start date La fecha debe ser antes de la fecha de terminación")).to eq(true)
  end

  it "should validate start date is different than end date" do 
    treatment = FactoryGirl.build(:treatment)
    treatment.start_date = "2017-10-10"
    treatment.end_date = "2017-10-10"
    treatment.save
    expect(treatment.errors.full_messages.include?("Start date La fecha debe ser antes de la fecha de terminación")).to eq(true)
  end

  it "should validate end date is the next day" do 
    treatment = FactoryGirl.build(:treatment)
    treatment.start_date = Date.today
    treatment.end_date = Date.today + 1.days
    expect(treatment.save).to eq(true)
  end
end
