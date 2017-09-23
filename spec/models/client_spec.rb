require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:client) {FactoryGirl.build(:client)}
  subject {client}

  it { should belong_to(:channel) }
  it { should have_many(:treatments) }
  it { should have_many(:client_appointments) }
  it { should validate_presence_of(:fname) }
  it { should validate_presence_of(:lname) }
  it { should validate_presence_of(:folio) }
  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:neighborhood) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:zipcode) }
  it { should validate_presence_of(:house_phone) }
  it { should validate_presence_of(:mobile_phone) }
  it { should validate_presence_of(:age) }
  it { should validate_presence_of(:tutor_name) }
  it { should validate_presence_of(:contact_date) }
  it { should validate_numericality_of(:zipcode).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:zipcode).only_integer }
  it { should validate_numericality_of(:age).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:age).only_integer }

  context "contact date validations" do
    context "with contact date after today" do
      it "should reject contact date as tomorrow" do
        client = FactoryGirl.build(:client)
        client.contact_date = Date.tomorrow
        client.save
        expect(client.errors.full_messages.include?("Contact date debe ser antes de mañana")).to eq(true)
      end

      it "should reject contact date as any time future" do
        client = FactoryGirl.build(:client)
        client.contact_date = Date.today + (rand(600) + 1).days
        client.save
        expect(client.errors.full_messages.include?("Contact date debe ser antes de mañana")).to eq(true)
      end
    end

    context "with contact date today or before" do
      it "should accept contact date as tomorrow" do
        client = FactoryGirl.build(:client)
        client.contact_date = Date.today
        expect(client.save).to eq(true)
      end

      it "should reject contact date as any time future" do
        client = FactoryGirl.build(:client)
        client.contact_date = Date.today - (rand(600) + 1).days
        expect(client.save).to eq(true)
      end
    end
  end

end
