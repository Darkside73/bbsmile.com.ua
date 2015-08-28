require 'rails_helper'

describe Order do
  context "when save" do
    let(:variants) { create_list :variant, 2}
    it "creates order, suborders and user, generates uuid" do
      order = Order.new(
        notes: 'some notes',
        user_attributes: {
          first_name: 'John', last_name: 'Doe',
          email: 'some@email', phone: '123456'
        },
        suborders_attributes: [
          { variant: variants.first },
          { variant: variants.second }
        ]
      )
      expect { order.save }.to change { Order.count }.by(1)
      order.reload
      expect(order.suborders).to have(2).things
      expect(order.user).to be_instance_of(User)
      expect(order.user).to_not be_new_record
      expect(order.uuid).to_not be_empty
    end

    it "does not save order without suborders" do
      order = Order.new
      expect(order).to be_valid
      expect(order.save).to be_falsy
    end

    it "fails validation if user not valid" do
      expect(
        order = Order.new(user_attributes: { email: 'email' })
      ).to have(1).error_on(:'user.email')
      expect { order.save }.not_to change { Order.count }
    end

    let(:user) { create :user }
    it "prevents user email duplications" do
      order = Order.new(
        user_attributes: { email: user.email, phone: '123456' }
      )
      expect { order.save }.not_to change { User.count }
      expect { user.reload }.not_to change { user.name + user.phone }
    end

    it "saves current values of user name and phone in order" do
      order = Order.new user_attributes: attributes_for(:user, phone: '456789')
      order.suborders = create_list :suborder, 2
      expect { order.save }.to change { order.user_phone and order.user_name }
    end

    it "calculate total" do
      suborder1 = create :suborder, quantity: 2
      suborder2 = create :suborder, quantity: 3
      order = Order.new suborders: [suborder1, suborder2]
      order.validate
      expect(order.total).to eq(suborder1.total + suborder2.total)
    end

    context "when suborder invalid" do
      it "do not take it into account" do
        invalid_suborder = build :suborder, price: 'foo', quantity: 'bar'
        valid_suborder = build :suborder, quantity: 1
        order = Order.new suborders: [valid_suborder, invalid_suborder]
        expect(order.valid?).to be_falsy
        expect(order.size).to eq(1)
        expect(order.total).to eq(valid_suborder.price)
      end
    end
  end

  context "when assign suborder" do
    let(:suborders) { create_list :suborder, 2, variant: create(:variant) }
    let(:suborder) { create :suborder }
    it "merge suborders with same product variant" do
      order = Order.new
      order.suborders = suborders
      order.suborders << suborder
      expect(order.suborders.size).to eq(2)
    end
  end

  context "when operate with suborders" do
    let(:suborders) { create_list :suborder, 3 }
    let(:order) { Order.new }
    describe "#remove_suborder" do
      it "remove suborder by index" do
        order.suborders = suborders
        order.remove_suborder 1
        expect(order.size).to eq(2)
      end
    end

    let(:variant) { create :variant, price: 10 }
    let(:suborder) { create :suborder, variant: variant }
    describe "#update_suborder" do
      it "change suborder quantity by index" do
        order.suborders << suborder
        expect {
          order.update_suborder(0, 2)
        }.to change { order.total }.by(variant.price)
      end
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
