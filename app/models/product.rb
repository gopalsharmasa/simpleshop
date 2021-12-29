class Product < ApplicationRecord
  belongs_to :shop
  has_many :order_items,:dependent => :destroy
  has_many :products, through: :order_items

  validates :title, presence: true
  validates :price, presence: true
  validates :stock, presence: true
end
