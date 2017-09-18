require 'rails_helper'

RSpec.describe Channel, type: :model do
  let(:channel) {FactoryGirl.build(:channel)}
  subject {channel}

  it { should validate_presence_of(:name) }
end