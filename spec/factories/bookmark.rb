require 'faker'

FactoryBot.define do
  factory :bookmark do
    title Faker::Hipster.sentence
    link Faker::Internet.url
    user
  end
end
