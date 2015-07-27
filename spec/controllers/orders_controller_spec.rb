require 'rails_helper'

describe OrdersController do
  describe 'POST create' do
    before :each do
      session[:cart] = Order.new
      session[:cart].suborders << build(:suborder)
      session[:cart].suborders << build(:suborder)
    end
    context "when format json" do
      it 'creates order' do
        request.env["HTTP_ACCEPT"] = 'application/json'
        xhr :post, :create, order: {
          user_attributes: attributes_for(:user)
        }
        expect(flash[:success]).to have_content(/created/i)
        expect(session[:cart]).to be_nil
      end
    end
    context "when format html" do
      it 'creates order and do redirect' do
        post :create, order: {
          user_attributes: attributes_for(:user)
        }
        expect(flash[:success]).to have_content(/created/i)
        expect(response).to redirect_to(cart_checkout_path)
        expect(session[:cart]).to be_nil
      end
    end
  end
end
