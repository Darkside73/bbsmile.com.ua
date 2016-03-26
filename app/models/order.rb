class Order < ApplicationRecord
  include OrderObserver
  include ActionView::Helpers::NumberHelper

  belongs_to :user
  has_many   :suborders, dependent: :destroy do
    def <<(suborder)
      suborder_with_same_variant = proxy_association.owner.suborders.find do |s|
        s.variant == suborder.variant
      end
      super unless suborder_with_same_variant
      proxy_association.owner.validate
    end
  end
  has_many :payments

  enum payment_method:  [:cash_to_courier, :cash_on_delivery, :liqpay]
  enum status:          [:placed, :pending, :paid, :refunded]

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :suborders
  accepts_nested_attributes_for :payments

  attr_accessor :delivery_info

  validates_numericality_of :total_correction

  before_validation    :setup_user_validation, on: :create
  validates_associated :suborders
  after_validation     :calculate_total
  before_create        :save_user
  before_save          :check_for_suborders, :save_delivery_info

  default_scope -> { order(created_at: :desc) }

  def suborders= suborders
    suborders_to_write = []
    suborders.each do |suborder|
      suborder_with_same_variant = suborders_to_write.find do |s|
        s.variant == suborder.variant
      end
      suborders_to_write << suborder unless suborder_with_same_variant
    end
    association(:suborders).writer suborders_to_write
    validate
  end

  def autosave_associated_records_for_user
    if user
      self[:user_phone] = user.phone
      self[:user_name]  = user.name
      if user.email.present?
        User.find_by(email: user.email).try(:tap) { |u| self.user = u }
      end
    end
  end

  def number
    id.to_s
  end

  def size
    valid_suborders.inject(0) { |size, suborder| size + suborder.quantity }
  end

  def original_total
    total + total_correction
  end

  def remove_suborder(index)
    self.suborders = suborders.to_a.tap { |s| s.delete_at(index) }
  end

  def update_suborder(index, quantity)
    suborders[index].try { |s| s.quantity = quantity }
    calculate_total
  end

  def total_with_currency
    number_to_currency total
  end

  def description
    suborders.map(&:title).join(", ")
  end

  def valid_suborders
    suborders.select(&:valid?)
  end

  private

  def setup_user_validation
    if user
      user.disable_email_uniqueness = true
      user.required_email = true if liqpay?
    end
  end

  def save_user
    user.save
    # its very strange... why rails does not do this automaticaly?
    self.user_id = user.id
  end

  def check_for_suborders
    throw(:abort) unless suborders.any?
  end

  def save_delivery_info
    unless delivery_info.blank?
      self[:notes] ||= ''
      self[:notes] << "\nДоставка: #{delivery_info}"
    end
  end

  def calculate_total
    original_total = valid_suborders.inject(0) do |total, suborder|
      total + suborder.total
    end
    self[:total] = original_total + total_correction
  end
end
