class Category < Page

  validates :title, :url, presence: true
  validates :url, uniqueness: true

  before_save do |category|
    raise ActiveRecord::ActiveRecordError if category.parent && category.parent.leaf
  end

  def self.arrange
    Page.unscoped.where(type: self.model_name).arrange(order: 'position')
  end


end