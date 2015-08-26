FactoryGirl.define do
  factory :order do
    user
    suborders { create_list :suborder, 2 }
    factory :placed_order do
      status :placed
    end
    factory :pending_order do
      status :pending
    end
  end
end
