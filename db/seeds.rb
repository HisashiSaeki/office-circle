# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

4.times do |n|
  Employee.find_or_create_by!(
    department_id: "#{n + 1}",
    last_name: "田中#{n + 1}",
    first_name: "太朗#{n + 1}",
    last_name_furigana: "タナカ#{n + 1}",
    first_name_furigana: "タロウ#{n + 1}",
    introduction: "test#{n + 1}",
    birthdate: "2023-04-0#{n + 1}",
    prefecture: "東京都",
    email: "test#{n + 1}@gmail.com",
    password: "123456",
    is_active: true
  )
end

Admin.find_or_create_by!(
  email: "admin@admin.com",
  password: "administrator"
  )

Department.find_or_create_by!(
  [
    {name: "営業部"},
    {name: "開発部"},
    {name: "人事部"},
    {name: "企画部"}
  ]
)
  
4.times do |n|
  Post.find_or_create_by!(
    employee_id: "#{n + 1}",
    title: "テストタイトル#{n + 1}",
    body: "テスト本文#{n + 1}",
    is_published: true
  )
end
