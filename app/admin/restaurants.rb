ActiveAdmin.register Restaurant do
  remove_filter :qr_attachment, :qr_blob
  permit_params :name, :address, :owner_name, :owner_email, :qr_code
  
  # if current_admin_user.role == "admin"
  #   menu false
  # end
  # menu false, if true 
  show do
    attributes_table do
      row :qr do |item|
        image_tag url_for(item.qr), size: "250x250" if item.qr.present?
      end
      row :name
      row :address
      row :owner_name
      row :owner_email
      row :qr_code
    end
  end
end
