class AvailabilitySubscribersController < ApplicationController
  respond_to :json

  def create
    variant = Variant.find subscriber_params[:variant_id]
    subscriber = variant.availability_subscribers.new(subscriber_params)
    subscriber.save
    respond_with subscriber, location: root_url
  end

  private

  def subscriber_params
    params.require(:availability_subscriber).permit(:variant_id, :email, :phone)
  end
end
