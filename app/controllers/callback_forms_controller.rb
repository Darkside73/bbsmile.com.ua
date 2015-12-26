class CallbackFormsController < ApplicationController

  def create
    form = CallbackForm.new form_params
    respond_to do |format|
      if form.valid?
        if form.quick_order?
          ManagerMailer.quick_order_message(form).deliver_now
        else
          ManagerMailer.callback_message(form).deliver_now
        end
        flash.now[:success] = I18n.t('flash.message.callbacks.created')
        format.json { render json: flashes_in_json, status: :created }
      else
        format.json { render json: form.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def form_params
    params.require(:callback_form)
          .permit(:name, :phone, :product_title, :from_cart)
  end
end
