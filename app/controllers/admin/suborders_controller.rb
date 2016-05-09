class Admin::SubordersController < Admin::ApplicationController

  def update
    suborder = Suborder.find params[:id]
    if suborder_params[:variant_unavailable]
      suborder.make_variant_unavailable!
    end
    redirect_to [:admin, suborder.order]
  end

  private

  def suborder_params
    params.require(:suborder).permit(:variant_unavailable)
  end
end
