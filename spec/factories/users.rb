FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    phone { '+375293785894' }
    password { "StrongPWD123" }
    password_confirmation { "StrongPWD123" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    confirmed_at { Time.zone.now }
    role_type { "user" }
  end
end
