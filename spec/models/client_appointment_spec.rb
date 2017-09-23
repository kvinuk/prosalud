require 'rails_helper'

RSpec.describe ClientAppointment, type: :model do
  let(:client_appointment) {FactoryGirl.build(:client_appointment)}
  subject {client_appointment}

  it { should belong_to(:client) }
  it { should belong_to(:therapist) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:date) }

  validates_date :date, :on_or_after => :today,
                        :on_or_after_message => 'date must be after today',


end
