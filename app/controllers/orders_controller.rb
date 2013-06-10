class OrdersController < ApplicationController

  def create
    order = Order.new order_params
    respond_to do |format|
      if order.save
        flash.now[:success] = I18n.t 'flash.message.orders.created', order_id: order.id
        format.json {
            render json: order.as_json.merge(flashes_in_json), status: :created
        }
      else
        format.json { render json: order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def order_params
      params.require(:order).permit(
        :variant_id, :notes,
        user_attributes: [:name, :email, :phone, :subscribed]
      )
    end
end
