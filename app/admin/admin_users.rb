ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :role, :restaurant_id

  controller do
    before_action :restrict_admin_access

    def scoped_collection
      if current_admin_user.super_admin?
        AdminUser.all
      else
        AdminUser.none
      end
    end

    private

    def restrict_admin_access
      unless current_admin_user.super_admin?
        redirect_to admin_dashboard_path, alert: "You are not authorized to access this page."
      end
    end
  end

  # menu false if proc { current_admin_user.admin? }

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role
      f.input :restaurant
    end
    f.actions
  end
end
