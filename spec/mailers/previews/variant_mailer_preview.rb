class VariantMailerPreview < ActionMailer::Preview
  def available
    VariantMailer.available(Variant.last, User.last.email)
  end

  def unavailable
    VariantMailer.unavailable(Variant.last, User.last)
  end
end
