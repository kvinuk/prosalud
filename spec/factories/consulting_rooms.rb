FactoryGirl.define do
  sequence :room_name do |n|
    "consultorio #{n}"
  end
  factory :consulting_room do
    sequence(:name) { |n| "consultorio #{n}" }
    room_type { %w[Nutriología Psicología].sample } 
  end
end
