class AvailabilitySubscriber < ApplicationRecord
  belongs_to :variant

  validates_uniqueness_of :email, scope: :variant, allow_blank: true
  validates_uniqueness_of :phone, scope: :variant, allow_blank: true

  validates :email, presence: true, unless: -> { phone.present? }
  validates :phone, presence: true, unless: -> { email.present? }

  validates :email, format: { with: /.+@.+/, message: I18n.t('errors.messages.email') },
                    allow_blank: true

  after_validation do
    errors.delete(:phone) unless errors[:email].empty?
  end

  # it should happens by default like in page model...
  auto_strip_attributes :email, :phone, nullify: true
end
