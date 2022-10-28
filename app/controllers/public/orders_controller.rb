class Public::OrdersController < Public::ApplicationController
  def new
    @order=Order.new
    @order.customer_id=current_customer.id
    @customer=current_customer
  end

  def confirm
    # @order = Order.new(order_params)
    # @order.postal_code = current_customer.postal_code
    # @order.address = current_customer.address
    # @order.name = current_customer.first_name + current_customer.last_name
    # @address = Address.find(params[:order][:address_id])
    # @order.postal_code = @address.postal_code
    # @order.address = @address.address
    # @order.name = @address.name
    @order = Order.new(order_params)
    if params[:order][:address_number] == "0"
      @order.name = current_customer.last_name
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
    elsif params[:order][:address_number] == "1"
      if Address.exists?(name: params[:order][:address_id])
        @order.name = Address.find(params[:order][:address_id]).name
      @order.address = Address.find(params[:order][:address_id]).address
      @order.postal_code = Address.find(params[:order][:address_id]).postal_code
      else
      render :new
      end
    elsif params[:order][:address_number] == "2"
        address_new = current_customer.addresses.new(address_params)
      if address_new.save
      else
        render :new
      end
    end
    @cart_items = current_customer.cart_items.all
    @total=0
    @total_price=@cart_items.inject(0) { |sum, item| sum + item.subtotal}+800
    @cost=800
  end

  def thanks
  end

  def create
    @order=Order.new(order_params)
    @order.customer_id=current_customer.id
    if @order.save
      current_customer.cart_items.each do |cart_item|
        order_detail=OrderDetail.new
        order_detail.order_id=@order.id
        order_detail.item_id=cart_item.item_id
        order_detail.price=cart_item.item.price
        order_detail.amount=cart_item.amount
        order_detail.save
      end
      current_customer.cart_items.destroy_all
      redirect_to public_order_thanks_path
    else render :new
    end
  end

  def index
    @order_details=OrderDetail.all
    @orders=current_customer.orders
    @customer=current_customer
  end

  def show
    @order=Order.find(params[:id])
    @order_detail=@order.order_details
    @cost=800
  end

  private

  def order_params
    params.require(:order).permit(:payment_method,:postal_code,:address,:name,:total_payment)
  end

  def address_params
  params.require(:order).permit(:name, :address,:postal_code,:address_id)
  end


end
