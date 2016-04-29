class VariantMailer < ActionMailer::Base
  default from: "Babysmile <smile@bbsmile.com.ua>"
  layout 'mailers_default'

  def available(variant, email)
    @variant = variant
    mail to: email, subject: I18n.t('mailers.variant.available.subject')
  end
end
