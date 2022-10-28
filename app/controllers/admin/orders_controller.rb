class Admin::OrdersController < Admin::ApplicationController
  def show
    @order=Order.find(params[:id])
    @order_details=@order.order_details.all
  end

  def update
  end
end
