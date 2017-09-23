require 'rails_helper'

RSpec.describe Service, type: :model do
  let(:service) {FactoryGirl.build(:service)}
  subject {service}

  it { should have_many(:treatments) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:initial_price) }
  it { should validate_presence_of(:subsequent_price) }
  it { should validate_presence_of(:community_price) }
  it { should validate_numericality_of(:initial_price) }
  it { should validate_numericality_of(:subsequent_price) }
  it { should validate_numericality_of(:community_price) }
  it { should validate_numericality_of(:initial_price).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:subsequent_price).is_greater_than_or_equal_to(0)}
  it { should validate_numericality_of(:community_price).is_greater_than_or_equal_to(0)}
end