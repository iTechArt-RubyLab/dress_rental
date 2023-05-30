FactoryBot.define do
  factory :salon do
    name { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    rating { nil }
    owner { association(:user) }

    factory :salon_with_products do
      after(:create) do |salon|
        salon.products << create_list(:product, 3, salon:)
      end
    end
  end
end
