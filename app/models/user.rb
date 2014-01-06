class User < ActiveRecord::Base
  has_many :orders

  attr_accessor :creation_with_order

  validate :phone_format_should_contains_digits, if: :phone
  validates :email, format: { with: /.+@.+/, message: I18n.t('errors.messages.email') },
                    allow_blank: true
  validates :email, uniqueness: true, unless: :creation_with_order

  nilify_blanks only: :email

  private

  def phone_format_should_contains_digits
    digits_count = phone.scan(/\d+/).join.length
    errors.add :phone, I18n.t('errors.messages.phone') if digits_count < 6
  end
end
