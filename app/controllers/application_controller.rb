class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protect_from_forgery

  protected

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || dashboard_path
  end

  def layout_by_resource
    if devise_controller?
      "sign"
    else
      "application"
    end
  end

  def delayed_job_admin_authentication
    authenticate_admin!
  end

  def authenticate_admin!
    current_user && current_user.is_admin?
  end

end
