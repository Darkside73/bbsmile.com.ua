class Category < Page

  def self.arrange
    Page.where(type: self.model_name).arrange(order: 'position')
  end
end