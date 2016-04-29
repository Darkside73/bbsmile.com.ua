class OrderMailerPreview < ActionMailer::Preview
  def new_order
    OrderMailer.new_order(Order.last)
  end
end
