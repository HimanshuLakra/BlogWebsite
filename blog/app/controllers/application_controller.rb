class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout :layout_by_resource

  after_filter :store_location

  def store_location

    return unless request.get?
    if (request.path != "/users/sign_in" &&
      request.path != "/users/sign_up" &&
      request.path != "/users/password/new" &&
      request.path != "/users/password/edit" &&
      request.path != "/users/confirmation" &&
      request.path != "/users/sign_out" &&
      request.path != "/" &&
      !request.xhr?) # don't store ajax calls

    puts " Request ---------------------------------------#{request.fullpath}"
    session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for resource
    session[:previous_url] || root_path
  end

  private

  def layout_by_resource
    if devise_controller? and action_name != "user_dashboard"
      "registration_layout"
    else
      "application"
    end
  end

end
