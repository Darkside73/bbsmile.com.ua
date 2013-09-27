require 'spec_helper'

describe ContactsController do
  describe 'POST create' do
    it 'creates contact message' do
      ManagerMailer.should_receive(:contact_message) { double deliver: true }
      xhr :post, :create, contact: { name: 'Joe', message: 'Hi!' }, text: ''
      flash[:success].should have_content(/created/i)
    end
    it 'reject to create contact message if honey pot filled' do
      ManagerMailer.should_not_receive(:contact_message) { double deliver: true }
      xhr :post, :create, contact: { name: 'Joe', message: 'Hi!' }, text: 'Hello from spam bot'
      response.should be_success
    end
  end
end
