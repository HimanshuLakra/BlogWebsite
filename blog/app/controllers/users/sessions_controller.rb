class Users::SessionsController < Devise::SessionsController

  #before_filter :authenticate_user! , only: [:user_dashboard]
  # before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

  def user_dashboard

    redirect_to new_user_session_path if !user_signed_in?
    
    if user_signed_in?
      @posts = current_user.posts
      @user = current_user
    end
  end

  def update_user_image
  end

  def upload_user_image
    binding.pry

    @user = current_user

    if @user.picture.nil?
      @picture = @user.create_picture(params[:picture_attributes])
    else
      @picture = @user.picture.update_attributes(params[:picture_attributes])
    end
    
    redirect_to dashboard_path
  end

end
