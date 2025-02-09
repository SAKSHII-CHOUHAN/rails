ActiveAdmin.register Table do
  permit_params :table_number, :guest_quantity, :table_status, :restaurant_id

  controller do
    before_action :restrict_super_admin, only: [:edit, :update, :destroy, :new, :create]

    def scoped_collection
      if current_admin_user.super_admin?
        Table.all
      else
        Table.where(restaurant_id: current_admin_user.restaurant_id)
      end
    end

    private

    def restrict_super_admin
      if current_admin_user.super_admin?
        redirect_to admin_tables_path, alert: "Super Admin can only view menu items."
      end
    end
  end 
  # menu false if proc { current_admin_user.super_admin? }
end
