# frozen_string_literal: true

class CompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if @user.is_admin?
      return @user.companies if @user.is_newuser?

      scope.none
    end
  end

  def add_user?
    @user.is_admin?
  end
end
