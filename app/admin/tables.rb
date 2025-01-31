ActiveAdmin.register Table do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :table_number, :guest_quantity, :table_status, :restaurant_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:table_number, :guest_quantity, :table_status, :restaurant_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
