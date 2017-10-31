FactoryBot.define do
  factory :user do
    username { Faker::Name }
    password "password"
  end
end
