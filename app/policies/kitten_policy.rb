class KittenPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      return scope.all if @user.is_admin?
      return user_kittens if @user.is_newuser?

      scope.none
    end

    def user_kittens
      Kitten.joins(:house).where(house: { user_id: @user.id })
    end
  end
end
