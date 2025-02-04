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
  permit_params :name, :price, :category, :availability_status, :restaurant_id, images:[]
  
  form do |f|
    f.inputs do
      f.input :image, as:file
      f.input :name
      f.input :price
      f.input :category
      f.input :availability_status
      f.input :restaurant
    end
  end
end
