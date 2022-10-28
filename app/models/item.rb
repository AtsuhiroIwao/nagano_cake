class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_details
  belongs_to :genre

  has_one_attached :image

  def add_tax_price
  (self.price * 1.10).round
  end

  validates :name,uniqueness:true
end
