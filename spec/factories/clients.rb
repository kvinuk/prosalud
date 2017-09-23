FactoryGirl.define do
  factory :client do
    fname { FFaker::NameMX.first_name }
    lname { FFaker::NameMX.last_name }
    folio { "PX-#{rand(100_000)}-#{rand(1_000)}" }
    street { FFaker::Address.street_address }
    neighborhood { FFaker::Address.neighborhood }
    city { FFaker::AddressMX.municipality }
    zipcode { FFaker::AddressMX.postal_code }
    house_phone { FFaker::PhoneNumber.short_phone_number }
    mobile_phone { FFaker::PhoneNumber.short_phone_number }
    age { rand(100) }
    tutor_name { FFaker::NameMX.full_name }
    contact_date { Date.today - rand(1_000).days }
    observations { FFaker::Lorem.paragraph }
    channel { FactoryGirl.build :channel }
  end
end
