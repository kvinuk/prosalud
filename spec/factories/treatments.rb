FactoryGirl.define do
  factory :treatment do
    start_date {Date.today - (rand(100) + 50).days}
    end_date {Date.today - rand(49).days}
    client {FactoryGirl.build :client}
    therapist {FactoryGirl.build :therapist}
  end
end
