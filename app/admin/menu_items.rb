ActiveAdmin.register MenuItem do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :price, :category, :description, :availability_status, :restaurant_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  remove_filter :image_attachment, :image_blob
  permit_params :name, :price, :category, :availability_status, :restaurant_id, :image
  
  before_save do |item|
    item.restaurant_id = 2
  end

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
