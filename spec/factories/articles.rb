FactoryBot.define do
  factory :article do
    title { Faker::Lorem.characters(number: 20) }
    body { Faker::Lorem.characters(number: 200) }
    is_published { true }
    employee_id { 1 }
  end
end
