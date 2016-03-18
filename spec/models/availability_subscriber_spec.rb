require 'rails_helper'

describe AvailabilitySubscriber do
  let(:variant) { create :variant }
  before do
    create :availability_subscriber,
           variant: variant, email: 'a@b', phone: '123'
  end

  it 'validates uniqueness of variant and email' do
    expect(
      AvailabilitySubscriber.new(variant: variant, email: 'a@b')
    ).to have(1).error_on(:email)
  end

  it 'validates uniqueness of variant and phone' do
    expect(
      AvailabilitySubscriber.new(variant: variant, phone: '123').error_on(:phone)
    ).to include("already subscribed")
    subscriber = AvailabilitySubscriber.new(
      variant: variant, email: 'b@c', phone: ''
    )
    expect(subscriber.errors).to_not have_key(:phone)
  end

  it 'validates presence of email or phone' do
    subscriber = AvailabilitySubscriber.new(
      variant: variant, email: '', phone: ''
    )
    expect(subscriber).to have(1).error_on(:email)
    expect(subscriber.errors).to_not have_key(:phone)
  end
end
