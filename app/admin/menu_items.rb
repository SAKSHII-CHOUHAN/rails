ActiveAdmin.register MenuItem do
  remove_filter :image_attachment, :image_blob
  permit_params :name, :price, :category, :availability_status, :restaurant_id, :image
  
  # if current_admin_user.role == "super_admin"
  #   actions :index, :show 
  # end

  form do |f|
    f.inputs do
      f.input :image, as: :file
      f.input :name
      f.input :price
      f.input :category
      f.input :availability_status
      # if current_admin_user.role == "super_admin"
      #   f.input :restaurant
      # else
      # f.input :restaurant, input_html: {value: Restaurant.last}
      # end
    end
    f.actions
  end
  
  show do
    attributes_table do
      row :image do |item|
        image_tag url_for(item.image), size: "60x60"
      end
      row :name
      row :price
      row :availability_status
      row :category
      row :restaurant
    end
  end
end
