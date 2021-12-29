class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates_uniqueness_of :product_id, scope: :order_id
  validates :quantity, presence: true

  # before_create :update_pricing
  before_save :update_pricing

  after_save :update_order
  after_destroy :update_order

  def update_pricing
    self.base_price = self.product.price.to_f
    self.title = self.product.title
    self.total_price =  (self.quantity.to_i*self.base_price).round(2)
  end

  def update_order
    order = self.order
    order_total = order.order_items.pluck(:total_price).sum
    order.update(order_total: order_total)
  end


end
