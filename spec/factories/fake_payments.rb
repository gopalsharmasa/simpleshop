FactoryBot.define do
  factory :fake_payment do
    order { nil }
    user { nil }
    transaction_number { "MyString" }
    amount { "MyString" }
    payment_status { "MyString" }
  end
end
