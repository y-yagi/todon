# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    user_id user
    name { Faker::Lorem.word }
    deleted false
  end
end
