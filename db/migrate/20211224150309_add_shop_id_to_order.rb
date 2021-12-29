class AddShopIdToOrder < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :shop, null: true, foreign_key: true
  end
end
