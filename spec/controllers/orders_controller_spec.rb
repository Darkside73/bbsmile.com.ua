require 'rails_helper'
require 'service/liqpay/request'

describe OrdersController do
  describe 'POST create' do
    before :each do
      session[:cart] = []
      session[:cart] << { variant_id: create(:variant).id, quantity: 1 }
      session[:cart] << { variant_id: create(:variant).id, quantity: 2 }
    end
    it 'creates order' do
      request.env["HTTP_ACCEPT"] = 'application/json'
      xhr :post, :create, order: {
        payment_method: :cash_to_courier,
        user_attributes: attributes_for(:user)
      }
      expect(session[:cart]).to be_nil
    end
  end

  describe "liqpay API" do
    before do
      Rails.application.secrets.liqpay = {}
      Rails.application.secrets.liqpay['private_key'] = 'private_key'
      Rails.application.secrets.liqpay['public_key'] = 'public_key'
    end

    describe "GET pay" do
      let(:order) { create(:pending_order).reload }
      subject { get :pay, uuid: order.uuid }
      it "renders the pay template" do
        expect(subject).to render_template(:pay)
      end
    end

    describe "POST api-callback" do
      def data(params = {})
        fixture = Rails.root.join('spec/fixtures/api/liqpay_callback_request.yml')
        data = YAML.load File.read(fixture)
        data.merge! params
        Base64.encode64 data.to_json
      end

      def signature(data)
        Liqpay.new(Rails.application.secrets.liqpay.to_hash.symbolize_keys)
              .str_to_sign(
                Rails.application.secrets.liqpay['private_key'] +
                data +
                Rails.application.secrets.liqpay['private_key']
              )
      end

      let(:order) { create :pending_order }
      context "when success" do
        it "change order status to paid" do
          data = data(order_id: order.number, amount: order.total)
          expect {
            post :api_callback, data: data, signature: signature(data)
            order.reload
          }.to change { order.status }.from('pending').to('paid')
          expect(order.payments).to_not be_empty
        end
      end

      context "when signature mismatch" do
        it "response not success" do
          data = data(order_id: order.number, amount: order.total)
          expect {
            post :api_callback, data: data, signature: 'some BAD signature'
            order.reload
          }.to_not change { order.status }
          expect(response).to_not be_success
          expect(order.payments).to be_empty
        end
      end

      context "when status not success" do
        it "not change order status" do
          data = data(order_id: order.number, amount: order.total, status: 'failure')
          expect {
            post :api_callback, data: data, signature: signature(data)
            order.reload
          }.to_not change { order.status }
          expect(order.payments).to_not be_empty
          expect(response).to be_success
        end
      end
    end
  end
end
