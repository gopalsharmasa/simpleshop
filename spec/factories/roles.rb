FactoryBot.define do
  factory :role do
    title { "MyString" }
  end

  factory :role_customer, :class => Role do 
    title { "customer" }
  end

  factory :role_admin, :class => Role do 
    title { "admin" }
  end
end
