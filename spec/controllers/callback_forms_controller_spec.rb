require 'rails_helper'

describe CallbackFormsController do
  describe 'POST create' do
    it 'creates callback message' do
      ManagerMailer.should_receive(:callback_message) { double deliver: true }
      xhr :post, :create, callback_form: { name: 'Joe', phone: '056565656' }
      flash[:success].should have_content(/created/i)
    end
  end
end
