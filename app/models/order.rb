class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details
  enum payment_method: { credit_card: 0, transfer: 1 }

  def add_tax_price
  (self.price * 1.10).round
  end
  
end
