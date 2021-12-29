class Order < ApplicationRecord
  belongs_to :user
  belongs_to :shop, optional: true
  has_many :order_items,:dependent => :destroy
  has_many :fake_payments, dependent: :destroy
  
  validates :customer_name, presence: true
  validates :shipping_address, presence: true
  

end
