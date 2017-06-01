class UsersController < ApplicationController

 before_filter :authenticate_user! , only: [:user_dashboard,:upload_user_image] 

 def user_dashboard

	if user_signed_in?
	  @posts = current_user.posts
	  @user = current_user
	end
 end

 def upload_user_image

    @user = current_user

    if @user.picture.nil?
      @picture = @user.create_picture(params[:picture_attributes])
    else
      @picture = @user.picture.update_attributes(params[:picture_attributes])
    end
    
    redirect_to dashboard_path
 end
 
end