class OrderItemPolicy < ApplicationPolicy
	# https://github.com/varvet/pundit
	# In the generated ApplicationPolicy, the model object is called record.

	def index?
		# This action is permission
		# Pundit will call the current_user method
		user.customer?
	end

	def create?
		# This action is permission
		# Pundit will call the current_user method
		order = record.order
		order.user_id==user.id and !order.paid
	end

	def update?
		# This action is permission
		# Pundit will call the current_user method
		order = record.order
		order.user_id==user.id and !order.paid
	end

	def destroy?
		order = record.order
		order.user_id==user.id and !order.paid
	end

end