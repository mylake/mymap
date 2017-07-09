FactoryGirl.define do
  factory :place do
    sequence(:name) { |n| "place #{n}" }
    desc 'desc'
    category 'category'
  end
end
