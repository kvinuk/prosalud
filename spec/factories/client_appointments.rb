FactoryGirl.define do
  factory :client_appointment do
    date { Date.today + rand(1000).days }
    status { %w[Pendiente Finalizada].sample }
    comments { FFaker::Lorem.paragraphs }
    client { FactoryGirl.build :client }
    therapist { FactoryGirl.build :therapist }
    treatment { FactoryGirl.build :treatment }
    service { FactoryGirl.build :service }
    consulting_room { FactoryGirl.build :consulting_room }
    factory :client_appointment_without_room do 
      consulting_room nil
    end
  end
end
