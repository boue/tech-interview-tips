FactoryGirl.define do
  factory :question do
    title { Faker::Lorem.word }
    content { Faker::Lorem.sentence }
  end

  factory :user do
    provider { Faker::Lorem.word }
    uid { Faker::Lorem.word }
    name { Faker::Lorem.word }
    email { Faker::Internet.email }
  end

end