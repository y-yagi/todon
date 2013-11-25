FactoryGirl.define do
  factory :user do
    provider { %w(google twitter facebook).sample }
    uid  { rand(10000).to_s }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    deleted false
  end
end
