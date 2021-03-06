require 'rails_helper'

RSpec.describe Therapist, type: :model do
  let(:therapist) {FactoryGirl.create(:therapist)}
  subject {therapist}

  it { should have_many(:schedules)}
  it { should belong_to(:user) }
end
