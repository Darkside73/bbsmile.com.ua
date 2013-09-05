class User < ActiveRecord::Base
  has_many :orders

  attr_accessor :creation_with_order

  validates :phone, format: { with: /\d{3,}/, message: I18n.t('errors.messages.phone') }
  validates :email, format: { with: /.+@.+/, message: I18n.t('errors.messages.email') },
                    allow_blank: true
  validates :email, uniqueness: true, unless: :creation_with_order

  nilify_blanks only: :email
end
