class VariantMailerPreview < ActionMailer::Preview
  def available
    VariantMailer.available(Variant.last, User.last.email)
  end
end
