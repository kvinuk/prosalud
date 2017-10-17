FactoryGirl.define do
  factory :user do
    name { FFaker::NameMX.full_name }
    email { FFaker::Internet.email }
    password "123456"
    name { FFaker::NameMX.first_name }
    role_type { %w[Administrador Recepcionista Psicologo Nutriologo].sample }
  end
end