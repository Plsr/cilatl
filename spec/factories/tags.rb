FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "Field #{n}"}
  end
end
