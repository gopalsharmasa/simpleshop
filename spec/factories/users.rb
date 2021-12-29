FactoryBot.define do
  # factory :user do
  #   email { "MyString" }
  #   password_digest { "MyString" }
  # end

  factory :user_customer, :class => User do
    email { 'customer@example.com' }
    password { '123456' }
    after(:create) do |user|
      role = create(:role_customer)
      Assignment.where(user_id: user.id, role_id: role.id).first_or_create
    end
  end

  factory :user_admin, :class => User do
    email { 'admin@example.com' }
    password { '123456' }
    after(:create) do |user|
      role = create(:role_admin)
      Assignment.where(user_id: user.id, role_id: role.id).first_or_create
    end
  end

  factory :customer_admin, :class => User do
    email { 'customer.admin@example.com' }
    password { '123456' }
    after(:create) do |user|
      admin_role = create(:role_admin)
      customer_role = create(:role_customer)
      Assignment.where(user_id: user.id, role_id: admin_role.id).first_or_create
      Assignment.where(user_id: user.id, role_id: customer_role.id).first_or_create
    end
  end

end
