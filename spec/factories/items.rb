FactoryBot.define do
  factory :item do
    name { 'MyString' }
    description { 'MyText' }
    category_id { 2 }
    condition_id { 2 }
    shipping_fee_id { 2 }
    shipping_origin_id { 2 }
    shipping_day_id { 2 }
    price { 300 }
    association :user

    after(:build) do |item|
      item.image.attach(
        io: Rails.root.join('public/images/test_image.png').open,
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
end
