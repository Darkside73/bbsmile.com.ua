class OrderMailerPreview < ActionMailer::Preview
  def new_order
    OrderMailer.new_order(Order.take)
  end
end
