class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json

  before_filter :authenticate_user!, only: [:new,:edit,:update,:create,:destroy,:user_dashboard]

  def index
    @posts = Post.paginate(:page => params[:page],:per_page => 8)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.includes([:tags, :comments => 
            [:user => :picture, :replies => [:user => :picture]]])
            .where("posts.id = #{params[:id]}").first
            
    @comments =  @post.comments
    @post_image = @post.picture
    @post_tags = @post.tags
    @new_comment = @post.comments.build

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @posts_tags = @post.posts_tags.build
    build_tags_for_new_post


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit

    @post = Post.find(params[:id])
    @tags = Tag.select("name,id")
    @tag_options = @tags.collect {|tag| [tag.name, tag.id]}
  end

  def user_dashboard
    @posts = current_user.posts
    @user = current_user
  end

  # POST /posts
  # POST /posts.json
  def create
    @user = current_user
    params[:post][:name] = @user.email
    
    # @tag_params = params[:post][:posts_tags_attributes]["0"][:tag_id]
    # posts_tags_attributes_hash = {}
    # tags_hash = {}
    # i=0

    # @tag_params.each do |tag_id|
      
    #   if !tag_id.nil?
    #     tag_id_hash = {}
    #     tag_id_hash[:tag_id] = tag_id 
    #     tags_hash[i.to_i] = tag_id_hash
    #     i+=1
    #   end
    # end

    # params[:post][:posts_tags_attributes] = tags_hash

    @post = @user.posts.create(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        build_tags_for_new_post
        format.html { render "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

 # def post_params
 #    params.require("post").permit("post_image")
 #  end 

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy

    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
      format.js
    end
  end

  private 

  def build_tags_for_new_post
    @tags = Tag.select("name,id")
    @tag_options = @tags.collect {|tag| [tag.name, tag.id]}
  end
end

 # @user = current_user
 #    params[:post][:name] = @user.email
    
 #    #add tag logic split tags with ','
 #    @tags = params[:post][:posts_tags_attributes]["0"][:tags].split(',')
 #    params[:post][:posts_tags_attributes] = {}
    
 #    i = 0
 #    @tags.each do |tag|
 #      post_tag_hash = {}
 #      t = Tag.find_or_create_by_name(tag.downcase)  
 #      post_tag_hash[:tag_id] = t.id  
 #      params[:post][:posts_tags_attributes]["#{i}".to_i] = post_tag_hash
 #      i+=1
 #    end
