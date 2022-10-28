class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

      has_many :cart_items
      has_many :orders
      has_many :addresses

      enum is_deleted: { 有効: false, 退会: true }
      # def active_for_authentication?
      #   super && (self.is_deleted == true)
      # end
end
