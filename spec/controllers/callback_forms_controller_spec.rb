require 'rails_helper'

describe CallbackFormsController do
  describe 'POST create' do
    it 'creates callback message' do
      expect(ManagerMailer).to receive(:callback_message) { double deliver_now: true }
      xhr :post, :create, callback_form: { name: 'Joe', phone: '056565656' }
      expect(flash[:success]).to have_content(/created/i)
    end
  end
end
