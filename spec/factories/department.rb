FactoryBot.define do
  factory :department do
    name { Faker::Lorem.characters(number: 5)}
  end
end