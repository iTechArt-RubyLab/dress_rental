FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 50..300) }
    description { Faker::Lorem.paragraph }
    association :salon

    trait :with_categories do
      after(:create) do |product|
        categories = create_list(:category, 3)
        categories.each do |category|
          create(:product_category, product:, category:)
        end
      end
    end
  end
end
