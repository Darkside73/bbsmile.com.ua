class PhoneValidator < ActiveModel::Validator
  def validate(record)
    digits_count = record.phone.scan(/\d+/).join.length
    record.errors.add :phone, I18n.t('errors.messages.phone') if digits_count < 6
  end
end
