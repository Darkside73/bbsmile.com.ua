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

    it "requires user email if Liqpay selected as payment method" do
      expect(
        order = Order.new(payment_method: :liqpay, user_attributes: { email: '' })
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

    context 'when existen user' do
      let(:user) { create :user }
      subject do
        Order.new user_attributes: {
          first_name: 'Joe', last_name: 'Doe',
          email: user.email, phone: '123456'
        }
      end
      before { subject.suborders = create_list :suborder, 2 }
      it "saves order new phone and name" do
        expect(subject.save).to be_truthy
        expect(subject.user_phone).to eq('123456')
        expect(subject.user_name).to eq('Joe Doe')
      end

      it 'do not save new phone and name to user' do
        expect { subject.save; user.reload }.to_not change {
          user.name and user.phone
        }
      end
    end

    context "calculate total" do
      let(:suborder1) { create :suborder, quantity: 2 }
      let(:suborder2) { create :suborder, quantity: 3 }
      subject { Order.new(suborders: [suborder1, suborder2]) }
      it "summarize suborders total" do
        subject.validate
        expect(subject.total).to be_within(0.01).of(
          suborder1.total + suborder2.total
        )
      end

      it "takes into account total correction" do
        subject.validate
        subject.total_correction = -20.50
        expect { subject.validate }.to change { subject.total }.by(-20.50)
        expect(subject.original_total).to eq(subject.total - 20.50)
      end

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
    subject { Order.new }

    let(:suborders) { create_list :suborder, 2, variant: create(:variant) }
    let(:suborder) { create :suborder }

    it "do not add suborder with same product variant" do
      subject.suborders = suborders
      subject.suborders << suborder
      expect(subject.suborders.size).to eq(2)
    end

    let(:offer) { create :offer }
    context 'when suborder with product offer' do
      it 'calculate discount' do
        suborder1 = create :suborder, variant: offer.product.master_variant
        suborder2 = create :suborder,
          variant: offer.product_offer.master_variant, offer_id: offer.id
        subject.suborders = [suborder1, suborder2]
        expect(suborder2.discount).to eq(offer.discount)
      end
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
end
