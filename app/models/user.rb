class User < ApplicationRecord

	has_secure_password
	validates_uniqueness_of :email,:allow_blank => false, :allow_nil => false, case_sensitive: false

	has_many :access_grants,
				class_name: 'Doorkeeper::AccessGrant',
				foreign_key: :resource_owner_id,
				dependent: :delete_all # or :destroy if you need callbacks

	has_many :access_tokens,
				class_name: 'Doorkeeper::AccessToken',
				foreign_key: :resource_owner_id,
				dependent: :delete_all # or :destroy if you need callbacks

	has_many :assignments, :dependent => :destroy
	has_many :roles, :through => :assignments

	has_many :orders, :dependent => :destroy 
	has_many :fake_payments, dependent: :destroy

	after_create :assign_role

	def assign_role
		role = Role.find_by_title("customer")
		self.assignments.where(role_id: role.id).first_or_create if role
	end

	def admin?
		self.roles.where(title: "admin").exists?
	end

	def customer?
		self.roles.where(title: "customer").exists?
	end
end
