class Public::CartItemsController <Public::ApplicationController
  def index
    # @cart_items=CartItem.all
    @cart_items=current_customer.cart_items
    @total=0
  end

  def update
    @cart_items=CartItem.find(params[:id])
    @cart_items.update(cart_item_params)
    redirect_to public_cart_items_path
  end

  def create
    @cart_item=CartItem.new(cart_item_params)
    @cart_item.customer_id=current_customer.id
    @cart_items=current_customer.cart_items.all
    @cart_items.each do |cart_item|
      if cart_item.item_id==@cart_item.item_id
        new_amount=cart_item.amount+@cart_item.amount
        cart_item.update_attribute(:amount,new_amount)
        @cart_item.delete
      end
    end
    @cart_item.save
    redirect_to public_cart_items_path
  end

  def destroy
  end

  def destroy_all
    @cart_items=current_customer.cart_items
    @cart_items.destroy_all
    redirect_to public_cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id,:amount)
  end
end
