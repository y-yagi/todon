FactoryGirl.define do
  factory :todo do
    user_id user
    detail { Faker::Lorem.sentence }
    tag_id { rand(10) }
    priority { rand(10) }
    end_date { 5.days.since.to_date }
    deleted false
  end
end
