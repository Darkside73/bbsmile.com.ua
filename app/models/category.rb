class Category < Page

  validates :title, :url, presence: true
  validates :url, uniqueness: true

  def self.arrange
    Page.unscoped.where(type: self.model_name).arrange(order: 'position')
  end
end