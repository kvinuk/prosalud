FactoryGirl.define do
  factory :schedule do
    start_time "7:00 am"
    end_time "7:00 pm"
    week_day { %w[Lunes Martes Miércoles Jueves Viernes].sample }
    therapist { FactoryGirl.build :therapist }
  end
end