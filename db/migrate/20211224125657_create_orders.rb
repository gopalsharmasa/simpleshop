class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.text :shipping_address
      t.float :order_total, default: 0.0
      t.datetime :paid_at
      t.boolean :paid, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
