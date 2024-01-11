FactoryBot.define do
  factory :employee do
    last_name { "佐々木" }
    first_name { "太朗" }
    last_name_furigana { "ササキ" }
    first_name_furigana { "タロウ" }
    department
    birthdate { "1996-06-22" }
    prefecture { "東京都" }
    email { Faker::Internet.email }
    password { "123456" }
    password_confirmation { "123456" }
    is_active { true }

    after(:build) do |employee|
      employee.profile_image.attach(io: File.open("spec/images/profile_image.jpg"), filename: "profile_image.jpg", content_type: "image/jpeg")
    end
  end
end
