class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create,:destroy,:destroy_reply,:create_reply,:new_reply]

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

  def destroy_reply
    @reply = Comment.find(params[:reply_id])
    @reply.destroy
    respond_to do |format|
      format.js
    end
  end

  def new_reply

    @parent_comment = Comment.find(params[:comment_id])
    @reply = @parent_comment.replies.build
    respond_to do |format|
      format.js
    end
  end

  def create_reply

    @parent_comment  = Comment.find(params[:parent_comment_id])
    params[:reply][:user_id] = current_user.id
    @reply = @parent_comment.replies.create(params[:reply])
  
    if @reply.save
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.html
      end
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