class FakePayment < ApplicationRecord
  belongs_to :order
  belongs_to :user

  after_create :update_transaction

  def update_transaction
    self.update(transaction_number: "#{self.id}#{(0..20).map { (65 + rand(26)).chr }.join}")
  end
end
