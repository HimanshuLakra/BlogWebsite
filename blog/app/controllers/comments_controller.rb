class CommentsController < ApplicationController
  before_filter :check_if_user_can_comment, only: [:create]

  def index
  end

  def create
    
  	@post = Post.find(params[:post_id])

    @hash_comment = params[:comment]
    @hash_comment[:user_id] = current_user.id
  	@comment = @post.comments.create(@hash_comment)  	
    respond_to do |format|
      format.js
    end
  end

  def show 
  end

  def update
  end

  def destroy
  	@post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def check_if_user_can_comment
    # if !user_signed_in?
    #   request.format = 'html'
    #   render 'devise/sessions/new', locals: {resource: User.new, resource_name: :user}
    # end
  end
end