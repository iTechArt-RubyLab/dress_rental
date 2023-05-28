FactoryBot.define do
  factory :rental do
    user
    product
    start_date { Date.tomorrow }
    end_date { Date.tomorrow + 3 }
    status { :unconfirmed }
    sequence(:total_price) { |n| product.price * (n + 1) }
    salon_rating { nil }
    user_rating { nil }
  end
end