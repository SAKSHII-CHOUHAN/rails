ActiveAdmin.register Restaurant do
  remove_filter :qr_attachment, :qr_blob
  permit_params :name, :address, :owner_name, :owner_email, :qr_code
  
  controller do
    before_action :restrict_admin_access, only: [:new, :create, :edit, :update, :destroy]

    def scoped_collection
      if current_admin_user.super_admin?
        Restaurant.all
      else
        Restaurant.where(id: current_admin_user.restaurant_id)
      end
    end

    private

    def restrict_admin_access
      if current_admin_user.admin?
        redirect_to admin_restaurants_path, alert: "Admins cannot modify restaurants."
      end
    end
  end

  # menu false if proc { current_admin_user.admin? }

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
