FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {"a1" + Faker::Internet.password(min_length: 6)}
    password_confirmation {password} 
    birthday              {Faker::Date.birthday}
    family_name           {Faker::Japanese::Name.last_name}
    first_name            {Faker::Japanese::Name.first_name}
    family_name_kana      {family_name.yomi}
    first_name_kana       {first_name.yomi}
  end
end