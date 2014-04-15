FactoryGirl.define do
  factory :question do
    title { Faker::Lorem.word }
    user { FactoryGirl.create(:user) }
  end

  factory :user do
    provider { Faker::Lorem.word }
    uid { Faker::Lorem.word }
    name { Faker::Lorem.word }
    email { Faker::Internet.email }
  end

  factory :answer do
    content { Faker::Lorem.sentence }
    user { FactoryGirl.create(:user) }
    question { FactoryGirl.create(:question) }
  end

  factory :comment do
    content { Faker::Lorem.sentence }
    user { FactoryGirl.create(:user) }
    association :commentable, factory: :question
  end
end