require 'faker'

FactoryBot.define do
  factory :bookmark do
    title Faker::Hipster.sentence
    url Faker::Internet.url
    media_type "Article"
    fields Faker::Hipster.words(3)
  end
end
