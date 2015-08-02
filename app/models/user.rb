class User < ActiveRecord::Base
  has_many :orders

  attr_accessor :first_name, :last_name, :creation_with_order

  validates_presence_of :first_name, :last_name, :phone
  validates :email, format: { with: /.+@.+/, message: I18n.t('errors.messages.email') },
                    allow_blank: true
  validates_with PhoneValidator, if: :phone
  validates :email, uniqueness: true, unless: :creation_with_order

  after_validation :write_name

  nilify_blanks only: :email

  private

  def write_name
    self[:name] = "#{first_name} #{last_name}"
  end
end
