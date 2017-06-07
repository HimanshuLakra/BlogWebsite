class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create,:destroy,:destroy_reply,:create_reply,:new_reply]

  def index
  end

  def create
    
  	@post = Post.find(params[:post_id])
    @hash_comment = comment_params
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
    @reply = @parent_comment.replies.create(reply_params)
  
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

  def comment_params
    params.require(:comment).permit(:body,:user_id,:post_id)
  end

  def reply_params
    params.require(:reply).permit(:body,:user_id,:post_id)
  end
end