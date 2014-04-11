FactoryGirl.define do
  factory :question do
    title { Faker::Lorem.word }
    content { Faker::Lorem.sentence }
  end
end