FactoryBot.define do
  factory :product do
    title { "MyString" }
    description { "MyText" }
    image_url { "MyString" }
    price { 1.5 }
    sku { "MyString" }
    stock { 1 }
    shop { nil }
  end
end
