class CallbackFormsController < ApplicationController

  def create
    form = CallbackForm.new params.require(:callback_form).permit(:name, :phone)
    respond_to do |format|
      if form.valid?
        ManagerMailer.callback_message(form).deliver_now
        flash.now[:success] = I18n.t('flash.message.callbacks.created')
        format.json { render json: flashes_in_json, status: :created }
      else
        format.json { render json: form.errors, status: :unprocessable_entity }
      end
    end
  end
end
