FactoryGirl.define do
  factory :related_page do
    page
    association :related, factory: :page
    type_of :similar
  end
end
