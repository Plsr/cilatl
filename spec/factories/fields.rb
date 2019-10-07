FactoryBot.define do
  factory :field do
    sequence(:name) { |n| "Field #{n}"}
  end
end
