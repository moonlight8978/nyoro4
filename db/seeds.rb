# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create_with(
  password: "Qe182182",
  profilename: "Moon",
  birthday: Date.new(1997, 12, 18),
  hide_birthday: 0,
  country: :vi
).find_or_create_by(
  email: "moonlight8978@gmail.com",
  username: "moon"
)
