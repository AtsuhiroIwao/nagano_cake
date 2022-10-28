class Public::ItemsController < Public::ApplicationController
  def index
    @items=Item.all
    @amount=Item.count
  end

  def show
    @item=Item.find(params[:id])
    @cart_item=CartItem.new
  end

  private

  def item_params
    params.require(:item).permit(:name,:introduction,:price,:image)
  end
end
