class Order < ActiveRecord::Base
  belongs_to :variant
  belongs_to :user, autosave: true

  accepts_nested_attributes_for :user

  before_validation :disable_user_email_uniqueness_validation, on: :create
  before_save :populate_order_user_attributes, on: :create
  before_save :memorize_variant_price, on: :create

  validates :variant, presence: true

  def autosave_associated_records_for_user
    if new_user = User.find_by(email: user.email)
      self.user = new_user
    else
      self.user.save!
    end
  end

  def number
    id.to_s
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
end
