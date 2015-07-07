require 'rails_helper'

describe OrdersController do
  describe 'POST create' do
    it 'creates order' do
      xhr :post, :create, order: {
        suborders_attributes: [
          { variant_id: create(:variant).id },
          { variant_id: create(:variant).id }
        ],
        user_attributes: attributes_for(:user)
      }
      expect(flash[:success]).to have_content(/created/i)
    end
  end
end
