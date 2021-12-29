# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  # The class has the same name as some kind of model class, only suffixed with the word "Policy".
  # The first argument is a user. In your controller, Pundit will call the current_user method to retrieve what to send into this argument
  # The second argument is some kind of model object, whose authorization you want to check. This does not need to be an ActiveRecord or even an ActiveModel object, it can be anything really.
  # The class implements some kind of query method, in this case update?. Usually, this will map to the name of a particular controller action.

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
