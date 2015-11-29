class User < ActiveRecord::Base
  has_many :orders

  attr_accessor :first_name, :last_name, :disable_email_uniqueness, :required_email

  validates :first_name, :last_name, presence: true, on: :create
  validates :name, :phone, presence: true
  validates :email, format: { with: /.+@.+/, message: I18n.t('errors.messages.email') },
                    allow_blank: true
  validates_presence_of :email, if: :required_email
  validates_with PhoneValidator, if: :phone
  validates :email, uniqueness: true, unless: :disable_email_uniqueness

  before_validation :write_name, on: :create

  nilify_blanks only: :email

  private

  def write_name
    self[:name] = "#{first_name} #{last_name}"
  end
end
