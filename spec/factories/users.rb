FactoryGirl.define do
  factory :user do
    name { FFaker::NameMX.full_name }
    email { FFaker::Internet.email }
    password "123456"
  end
end