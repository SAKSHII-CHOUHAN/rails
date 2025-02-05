ActiveAdmin.register Table do
  permit_params :table_number, :guest_quantity, :table_status, :restaurant_id

  # if current_admin_user.role == "super_admin"
  #   actions :index, :show
  # end
end
