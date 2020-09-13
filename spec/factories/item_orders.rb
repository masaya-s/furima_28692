FactoryBot.define do
  factory :item_order do
    token               { 'abc123' }
    user_id             { rand(1..10) }
    item_id             { rand(1..10) }
    postal_code         { '100-6390' }
    prefecture          { rand(2..48) }
    city                { '千代田区' }
    address             { '丸の内2-4-1' }
    building            { '丸の内ビルディング10F' }
    phone_number        { Faker::PhoneNumber.subscriber_number(length: 11) }
  end
end
