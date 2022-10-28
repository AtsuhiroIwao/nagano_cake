class Admin::HomesController < Admin::ApplicationController
  def top
    @orders=Order.all
    @amount=Order.count
  end
end
