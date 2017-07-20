class UsersController < ApplicationController

 before_filter :authenticate_user!  

 def user_dashboard
	  @posts = current_user.posts
	  @user = current_user
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