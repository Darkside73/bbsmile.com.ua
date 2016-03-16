class VariantMailer < ActionMailer::Base
  default from: "Babysmile <smile@bbsmile.com.ua>"

  def available(variant, email)
    @variant = variant
    mail to: email, subject: I18n.t('mailers.variant.available.subject')
  end
end
