class User < ActiveRecord::Base
  has_many :orders

  attr_accessor :creation_with_order

  validates :phone, presence: true
  validates :email, format: { with: /.*?@.*?/, message: I18n.t('errors.messages.email') },
                    allow_blank: true
  validates :email, uniqueness: true, unless: :creation_with_order
end
