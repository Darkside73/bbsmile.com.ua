class AvailabilitySubscriber < ApplicationRecord
  belongs_to :variant

  validates_uniqueness_of :email, scope: :variant
  validates_uniqueness_of :phone, scope: :variant

  validates :email, presence: true, unless: -> { phone.present? }
  validates :phone, presence: true, unless: -> { email.present? }
end
