FactoryGirl.define do
  factory :appointment_report do
    client_assistance false
    therapist_assistance false
    start_hour "2017-10-28 19:42:10"
    delay_responsible "MyString"
    client_appointment nil
  end
end
