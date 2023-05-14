FactoryBot.define do
  factory :item do
    name { Faker::Name.initials }
    introduction {Faker::Lorem.sentence}
    price {Faker::Number.between(from: 300, to: 9999999)}
    category_id {Faker::Number.between(from: 1, to: 10)}
    condition_id {Faker::Number.between(from: 1, to: 6)}
    postage_type_id {Faker::Number.between(from: 1, to: 2)}
    prefecture_id {Faker::Number.between(from: 1, to: 47)}
    shipping_day_id {Faker::Number.between(from: 1, to: 3)}
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
