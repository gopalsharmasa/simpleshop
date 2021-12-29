class ShopPolicy < ApplicationPolicy
	# https://github.com/varvet/pundit
	# In the generated ApplicationPolicy, the model object is called record.

	# The class has the same name as some kind of model class, only suffixed with the word "Policy".
	# The first argument is a user. In your controller, Pundit will call the current_user method to retrieve what to send into this argument
	# The second argument is some kind of model object, whose authorization you want to check. This does not need to be an ActiveRecord or even an ActiveModel object, it can be anything really.
	# The class implements some kind of query method, in this case update?. Usually, this will map to the name of a particular controller action.
	def index?
		user.customer? or user.admin?
	end
end