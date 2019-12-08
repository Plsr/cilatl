FactoryBot.define do
  factory :highlight do
    text "MyText"
    sequence(:index_in_article) { |n| n }
    bookmark
  end
end
