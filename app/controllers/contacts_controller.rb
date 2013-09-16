class ContactsController < ApplicationController

  def create
    contact = Contact.new contacts_params
    respond_to do |format|
      if contact.valid?
        ManagerMailer.contact_message(contact).deliver
        flash.now[:success] = I18n.t('flash.message.contacts.created')
        format.json { render json: flashes_in_json, status: :created }
      else
        format.json { render json: contact.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def contacts_params
    params.require(:contact).permit(:name, :email, :message)
  end
end