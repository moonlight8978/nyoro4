FactoryBot.define do
  factory :user_x, class: User do
    email "x@gmail.com"
    username "xmd"
    password "Qe182182"
    profilename "Moon"
    birthday Date.new(1997, 12, 18)
    birthday_visibility 0
    country :vi
  end
end
