ActiveAdmin.register MenuItem do
  remove_filter :image_attachment, :image_blob
  permit_params :name, :price, :category, :availability_status, :restaurant_id, :image
  
  controller do
    before_action :restrict_super_admin, only: [:edit, :update, :destroy, :new, :create]

    def scoped_collection
      if current_admin_user.super_admin?
        MenuItem.all
      else
        MenuItem.where(restaurant_id: current_admin_user.restaurant_id)
      end
    end

    private

    def restrict_super_admin
      if current_admin_user.super_admin?
        redirect_to admin_menu_items_path, alert: "Super Admin can only view menu items."
      end
    end
  end
  # menu false if proc { current_admin_user.super_admin? }
  # before_save do |item|
  #   byebug
  # end

  form do |f|
    f.inputs do
      f.input :image, as: :file
      f.input :name
      f.input :price
      f.input :category
      f.input :availability_status
      f.input :restaurant
    end
    f.actions
  end
  
  show do
    attributes_table do
      row :image do |item|
        image_tag url_for(item.image), size: "60x60" if item.image.present?
      end
      row :name
      row :price
      row :availability_status
      row :category
      row :restaurant
    end
  end
end
