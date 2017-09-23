FactoryGirl.define do
  factory :client_appointment do
    date { Date.today - rand(1000).days }
    status { ["Pendiente", "Finalizada"].sample }
    comments { FFaker::Lorem.paragraphs }
    client { FactoryGirl.build :client }
    therapist { FactoryGirl.build :therapist }
  end
end