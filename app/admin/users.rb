ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role, :restaurant_id
  
  form do |f|
    f.inputs "New Entry" do
      f.input :restaurant
      f.input :email
      f.input :password
      f.input :role 
    end
    f.actions
  end
  # if current_admin_user.role == "super_admin"
  #   actions :index, :show
  # end
end
