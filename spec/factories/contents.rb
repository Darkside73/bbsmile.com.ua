FactoryGirl.define do

  factory :content do
    text Faker::Lorem.paragraphs.to_sentence
  end
end
