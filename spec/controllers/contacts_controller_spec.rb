require 'rails_helper'

describe ContactsController do
  describe 'POST create' do
    it 'creates contact message' do
      expect(ManagerMailer).to receive(:contact_message) { double deliver_now: true }
      xhr :post, :create, contact: { name: 'Joe', message: 'Hi!' }, text: ''
      expect(flash[:success]).to have_content(/created/i)
    end
    it 'reject to create contact message if honey pot filled' do
      expect(ManagerMailer).to_not receive(:contact_message) { double deliver_now: true }
      xhr :post, :create, contact: { name: 'Joe', message: 'Hi!' }, text: 'Hello from spam bot'
      expect be_success
    end
  end
end
