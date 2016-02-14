class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :best, :popular]
  before_filter :set_user, :except => :show
  before_filter :set_post, :except => [:index, :new, :create, :best, :popular]

  def index
    @posts = @user.posts
  end

  def new
    @post = @user.posts.build
  end

  def edit
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = @user.posts.build(post_params)
    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to posts_path
    else
      render :new
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = 'Post was successfully deleted.'
    redirect_to posts_path
  end

  def update
    if @post.update_attributes(post_params)
      flash[:notice] = 'Post was successfully updated.'
      redirect_to posts_path
    else
      render :edit
    end
  end

  def popular
    @posts = Post.popular
  end

  def best
    @posts = Post.best
  end

  def comments
    @comments = @post.comments
  end

  def create_comment
    #@comment = @post.comments.build(params[:comment])
    #if @comment.save
  end

  private

  def set_user
    @user = current_user
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params[:post]
  end
end
