class Order < ActiveRecord::Base
  include OrderObserver

  belongs_to :user
  has_many   :suborders, dependent: :destroy do
    def <<(suborder)
      suborder_with_same_variant = proxy_association.owner.suborders.find do |s|
        s.variant == suborder.variant
      end
      if suborder_with_same_variant
        suborder_with_same_variant.merge_with suborder
      else
        super
      end
    end
  end

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :suborders

  before_validation    :disable_user_email_uniqueness_validation, on: :create
  validates_associated :suborders
  after_validation     :calculate_total
  before_create        :populate_order_user_attributes
  before_create        :save_user

  validates :suborders, presence: true

  def suborders= suborders
    suborders_to_write = []
    suborders.each do |suborder|
      suborder_with_same_variant = suborders_to_write.find do |s|
        s.variant == suborder.variant
      end
      if suborder_with_same_variant
        suborder_with_same_variant.merge_with suborder
      else
        suborders_to_write << suborder
      end
    end
    association(:suborders).writer suborders_to_write
  end

  def autosave_associated_records_for_user
    if user.email.present?
      User.find_by(email: user.email).try(:tap) { |u| self.user = u }
    end
  end

  def number
    id.to_s
  end

  def size
    valid_suborders.size
  end

  def remove_suborder(index)
    self.suborders = suborders.to_a.tap { |s| s.delete_at(index) }
  end

  def phone_number
    number = user_phone.gsub /[^+^\d]+/, ''
    country_phone_code = '+380'
    length = number.length
    if length > 13
      number = user_phone.chars.each_slice(user_phone.length/2)
                               .map(&:join)
                               .first
                               .gsub(/[^+^\d]+/, '')[0..13]
      length = number.length
    end
    if (9..13) === length
      number = country_phone_code[0..13-length-1] + number
      return number if number.start_with? country_phone_code
    end
  end

  def as_json options={}
    super only: :total,
          methods: :size,
          include: {
            suborders: { only: :quantity, methods: [:title, :total] }
          }
  end

  private

  def disable_user_email_uniqueness_validation
    user.creation_with_order = true if user
  end

  def populate_order_user_attributes
    self.user_name, self.user_phone = user.name, user.phone
  end

  def save_user
    self.user.save
    # its very strange... why rails does not do this automaticaly?
    self.user_id = user.id
  end

  def calculate_total
    self[:total] = valid_suborders.inject(0) { |total, suborder| total + suborder.total }
  end

  def valid_suborders
    suborders.select(&:valid?)
  end
end
