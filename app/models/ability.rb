class Ability
  include CanCan::Ability

  def initialize(admin_user)
    return unless admin_user.present?

      if admin_user.role == "super_admin"
        can :manage, :all
  
      elsif admin_user.role == "admin" 
        can :manage, Table, restaurant_id: admin_user.restaurant_id
        can :manage, User, restaurant_id: admin_user.restaurant_id
        can :manage, MenuItem, restaurant_id: admin_user.restaurant_id
        cannot : manage, Restaurant

      else
        cannot :manage, Table
        cannot :manage, User
        cannot :manage, MenuItem
        cannot :manage, Restaurant
      end
  end
end
