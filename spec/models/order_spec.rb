require 'rails_helper'

describe Order do
  context "when save" do
    let(:variant) { create :variant }
    it "creates order and user" do
      order = Order.new(
        variant: variant, notes: 'some notes',
        user_attributes: { email: 'some@email', phone: '123456', name: 'User' }
      )
      expect { order.save }.to change { Order.count }.by(1)
      order.reload
      expect(order.user).to be_instance_of(User)
      expect(order.user).to_not be_new_record
    end
    it "fails validation if user not valid" do
      expect(
        order = Order.new(
          variant: variant,
          user_attributes: { email: 'email' }
        )
      ).to have(1).error_on(:'user.email')
      expect { order.save }.not_to change { Order.count }
    end
    let(:user) { create :user }
    it "prevents user email duplications" do
      order = Order.new(
        variant: variant,
        user_attributes: { email: user.email, phone: '123456' }
      )
      expect { order.save }.not_to change { User.count }
      expect { user.reload }.not_to change { user.name + user.phone }
    end
    let(:order) { order = Order.new variant: variant, user_attributes: attributes_for(:user) }
    it "saves current values of user name and phone in order" do
      expect { order.save }.to change { order.user_phone and order.user_name }
    end
    it "saves current variant price in order" do
      order.save
      expect(order.price).to eq(variant.price)
    end
  end
  describe '#phone_number' do
    let(:order) { create :order }
    it 'return normalized phone number' do
      order = build :order, user_phone: '0671234567'
      expect(order.phone_number).to eq('+380671234567')
    end
    context 'when country phone code is not allowed' do
      it 'return nil' do
        order = build :order, user_phone: '38068995545'
        expect(order.phone_number).to be_nil
      end
    end
    context 'when two phone numbers in one field' do
      it 'return only first normalized phone number' do
        order = build :order, user_phone: '(123) 12-12-12 (456) 11-11-11'
        expect(order.phone_number).to eq('+380123121212')
      end
    end
    context 'when a small amount of digits in phone' do
      it 'return nil' do
        order = build :order, user_phone: '1234567'
        expect(order.phone_number).to be_nil
      end
    end
  end
end
