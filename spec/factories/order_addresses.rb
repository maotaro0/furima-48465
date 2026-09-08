FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { Faker::Address.city }
    addresses { Faker::Address.street_address }
    building { Faker::Address.secondary_address }
    phone_number { Faker::Number.number(digits: 11) }
    user_id { 1 }
    item_id { 1 }
    token { 'tok_test' }
  end
end
