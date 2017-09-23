FactoryGirl.define do
  factory :channel do
    name { FFaker::Company.name }
  end
end