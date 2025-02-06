class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    if resource.role == 'admin' || resource.role == 'super_admin'
      admin_dashboard_path
    else
      dashboard_index_path
    end
  end
end
