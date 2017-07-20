class PostsController < ApplicationController

  load_and_authorize_resource only: [:update,:destroy,:edit]
  before_filter :authenticate_user!,except: [:index,:show]
  before_filter :load_post, only: [:edit, :destroy, :show, :update]

  def index
    binding.pry
    get_paginated_posts
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @comments, @post_image, @post_tags, 
    @new_comment, @post_user_picture = @post.get_details

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @post = Post.new
    @posts_tags = @post.posts_tags.build
    build_tags_for_new_post

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  def edit
    @picture_attributes = @post.picture
    build_tags_for_new_post
  end

  def create
    @user = current_user
    params[:post][:name] = @user.email
    @post = @user.posts.create(post_params)

    respond_to do |format|
      if @post.save
        PostMailer.post_created(@user,@post).deliver
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        build_tags_for_new_post
        format.html { render "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update_attributes(post_params)
        PostMailer.post_updated(@post.user,@post).deliver
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        build_tags_for_new_post
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.js
    end
  end

  private 

  def build_tags_for_new_post
    @tags = Tag.select("name,id")
    @tag_options = @tags.collect {|tag| [tag.name, tag.id]}
  end

  def post_params
    params.require(:post).permit(:content,:name,:title,{tag_ids: []},{picture_attributes: []})
  end

  def get_paginated_posts
    @posts = Post.paginate(:page => params[:page],:per_page => 8)
  end

  def load_post
    @post = Post.find(params[:id])
  end
end

