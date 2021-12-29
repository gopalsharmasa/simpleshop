class OrderPolicy < ApplicationPolicy
	# https://github.com/varvet/pundit
	# In the generated ApplicationPolicy, the model object is called record.

	def index?
		user.customer? or user.admin?
	end

	def show?
		record.user_id==user.id
	end

	def update?
		# This action is permission
		# Pundit will call the current_user method
		record.user_id==user.id and !record.paid
	end

	def destroy?
		record.user_id==user.id and !record.paid
	end

end