FactoryGirl.define do
  factory :user do
    password 'mypassword'
    sequence(:email) { |n| "tester#{n}@mail.example.net" }
  end
end
