class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protect_from_forgery

  protected

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
