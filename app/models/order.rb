class Order < ActiveRecord::Base
  include OrderObserver

  belongs_to :variant
  belongs_to :user

  accepts_nested_attributes_for :user

  before_validation :disable_user_email_uniqueness_validation, on: :create
  before_create :populate_order_user_attributes
  before_create :memorize_variant_price
  before_create :save_user

  validates :variant, presence: true

  def autosave_associated_records_for_user
    if user.email.present?
      User.find_by(email: user.email).try(:tap) { |u| self.user = u }
    end
  end

  def number
    id.to_s
  end

  def as_json(options={})
    super include: {
      variant: { only: [:sku], methods: [:category_title, :title] }
    }
  end

  def phone_number
    number = user_phone.gsub /[^+^\d]+/, ''
    length = number.length
    if (9..13) === length
      '+380'[0..13-length-1] + number
    end
  end

  private

  def disable_user_email_uniqueness_validation
    user.creation_with_order = true if user
  end

  def populate_order_user_attributes
    self.user_name, self.user_phone = user.name, user.phone
  end

  def memorize_variant_price
    self.price = variant.price
  end

  def save_user
    self.user.save
    # its very strange... why rails does not do this automaticaly?
    self.user_id = user.id
  end
end
