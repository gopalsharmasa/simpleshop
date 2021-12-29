FactoryBot.define do
  factory :order do
    customer_name { "MyString" }
    shipping_address { "MyString" }
    order_total { 1.5 }
    paid_at { "2021-12-25 16:56:02" }
    paid { false }
    user { nil }
    shop { nil }
  end
end
