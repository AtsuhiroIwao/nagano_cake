class Public::HomesController < Public::ApplicationController
  def top
    @items=Item.all
  end

  def about
  end
end
