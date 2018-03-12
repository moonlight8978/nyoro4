# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create_with(
  password: "123456",
  profilename: "Moon",
  birthday: Date.new(1997, 12, 18),
  birthday_visibility: 0,
  country: :vi,
  accept_tos: "yes"
).find_or_create_by!(
  email: "moonlight8978@gmail.com",
  username: "moon"
)

User.create_with(
  password: "123456",
  profilename: "泉水茜",
  birthday: Date.new(1997, 12, 18),
  birthday_visibility: 0,
  country: :vi,
  accept_tos: "yes"
).find_or_create_by!(
  email: "b@gmail.com",
  username: "izumi_akn"
)

User.create_with(
  password: "123456",
  profilename: "konomi★きのこのみ★ｸﾛｺﾈ2 3/24発売★ﾄﾘﾉﾗｲﾝ:ｼﾞｪﾈｼｽ ",
  birthday: Date.new(1997, 12, 18),
  birthday_visibility: 0,
  country: :vi,
  accept_tos: "yes"
).find_or_create_by!(
  email: "c@gmail.com",
  username: "konominoco"
)
