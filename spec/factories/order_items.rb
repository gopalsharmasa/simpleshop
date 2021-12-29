FactoryBot.define do
  factory :order_item do
    quantity { 1 }
    title { nil }
    base_price { 2 }
    total_price { 2 }
    order { nil }
    product { nil }
  end
end