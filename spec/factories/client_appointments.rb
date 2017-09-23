FactoryGirl.define do
  factory :client_appointment do
    date "2017-09-23"
    status "MyString"
    comments "MyText"
    client nil
    therapist nil
  end
end
