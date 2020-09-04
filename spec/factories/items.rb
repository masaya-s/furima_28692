FactoryBot.define do
  factory :item do
    name             { 'ガラスコップ' }
    price            { rand(500..1500) }
    introduction     { 'キャラクターのガラスコップです。' }
    category         { 5 }
    status           { rand(2..6) }
    postage          { rand(2..3) }
    prefecture       { 14 }
    shipping_day     { rand(2..4) }
    association :user
  end
end
