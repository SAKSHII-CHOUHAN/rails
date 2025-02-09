ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role, :restaurant_id
  
  controller do
    before_action :restrict_super_admin_access, only: [:new, :create, :edit, :update, :destroy]

    def scoped_collection
      if current_admin_user.super_admin?
        User.all
      else
        User.where(restaurant_id: current_admin_user.restaurant_id)
      end
    end

    private

    def restrict_super_admin_access
      if current_admin_user.super_admin?
        redirect_to admin_users_path, alert: "Super Admins cannot modify users."
      end
    end
  end

  # menu false if proc { current_admin_user.super_admin? }

  form do |f|
    f.inputs "New Entry" do
      f.input :restaurant
      f.input :email
      f.input :password
      f.input :role 
    end
    f.actions
  end
end
