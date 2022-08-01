class HousePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      return scope.all if @user.is_admin?
      return @user.houses if @user.is_newuser?
      
      scope.none
    end
  end
end
