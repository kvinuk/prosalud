FactoryGirl.define do
  factory :therapist do
    user { FactoryGirl.build :user }
  end
end
