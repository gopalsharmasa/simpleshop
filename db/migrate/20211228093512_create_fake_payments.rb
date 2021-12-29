class CreateFakePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :fake_payments do |t|
      t.references :order, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :amount
      t.string :transaction_number
      t.string :payment_status, default: "initiated"

      t.timestamps
    end
  end
end
