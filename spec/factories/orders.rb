FactoryGirl.define do
  factory :order do
    user
    suborders { create_list :suborder, 2 }
  end
end
