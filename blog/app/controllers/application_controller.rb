class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    #binding.pry
    flash.keep(:alert)
    flash[:alert]=exception.message
    redirect_to new_user_session_path,:alert => exception.message
  end

  layout :layout_by_resource

  after_filter :store_location

  def store_location

    return unless request.get?
    if (!devise_controller? && request.path != "/" && !request.xhr?) # don't store ajax calls
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
