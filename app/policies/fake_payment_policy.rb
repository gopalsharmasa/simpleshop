class FakePaymentPolicy < ApplicationPolicy
	# https://github.com/varvet/pundit
	# In the generated ApplicationPolicy, the model object is called record.

	def update?
		# This action is permission
		# Pundit will call the current_user method
		order = record.order
		order.user_id==user.id and !order.paid #and record.payment_status=="initiated"
	end
end