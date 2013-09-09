require 'spec_helper'

describe ContactsController do
  describe 'POST create' do
    it 'creates contact message' do
      ManagerMailer.should_receive(:contact_message) { double deliver: true }
      xhr :post, :create, contact: { name: 'Joe', message: 'Hi!' }
      flash[:success].should have_content(/created/i)
    end
  end
end
