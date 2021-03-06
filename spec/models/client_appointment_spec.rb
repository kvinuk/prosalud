require 'rails_helper'

RSpec.describe ClientAppointment, type: :model do
  let(:client_appointment) { FactoryGirl.create(:client_appointment) }
  subject {client_appointment}

  it { should belong_to(:client) }
  it { should belong_to(:therapist) }
  it { should belong_to(:treatment) }
  it { should belong_to(:service) }
  it { should belong_to(:consulting_room) } 
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:date) }

end
