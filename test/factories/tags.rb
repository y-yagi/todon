# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    name { Faker::Lorem.word }
    deleted false

    trait :with_user do
      before(:create) { |blog| blog.user = create(:user) }
    end

    factory :todo_with_user, traits: [:user]
  end
end
