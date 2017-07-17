class CommentsController < ApplicationController

  before_filter :authenticate_user!

  def index
  end

  def create
  	@post = Post.find(params[:post_id])
    params[:comment][:user_id] = current_user.id
  	@comment = @post.comments.create(comment_params)
    authorize! :create,@comment  

    if @comment.save
      PostMailer.comment_on_post(@post,current_user,@comment.body).deliver
    end	

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
    authorize! :destroy,@comment 
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  def destroy_reply
    @reply = Comment.find(params[:reply_id])
    authorize! :destroy,@comment 
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
    params[:comment][:user_id] = current_user.id
    @reply = @parent_comment.replies.create(comment_params)
    authorize! :create,@reply 
  
    if @reply.save
      PostMailer.reply_on_comment(@parent_comment.post,current_user,@reply.body).deliver
    
      respond_to do |format|
        format.js
      end
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:body,:user_id,:post_id)
  end

end