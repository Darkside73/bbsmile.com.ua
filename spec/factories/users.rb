FactoryGirl.define do
  sequence(:email) { |n| Faker::Internet.email }

  factory :user do
    first_name { generate :name }
    last_name { generate :name }
    email { generate :email }
    phone '123-456'
    subscribed true
  end
end
