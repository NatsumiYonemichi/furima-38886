FactoryBot.define do
  factory :payment_purchase do
    post_code {"123-4567"}
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { Faker::Address.city }
    address { Faker::Address.street_address }
    building { Faker::Address.building_number }
    phone_number { Faker::Number.number(digits: rand(10..11)) }
    association :user_id
    association :item_id
  end
end
