ActiveAdmin.register Restaurant do
  remove_filter :qr_code_attach, :qr_code_blob
  permit_params :name, :address, :owner_name, :owner_email, :qr_code
  
  # if current_admin_user.role == "admin"
  #   menu false
  # end
  # menu false, if true 
end
