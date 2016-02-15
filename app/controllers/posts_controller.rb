class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :best, :popular, :comments, :create_comment]
  before_filter :set_user, :except => :show
  before_filter :set_post, :except => [:index, :new, :create, :best, :popular]

  def index
    @posts = @user.posts.paginate(:page => params[:page], :per_page => 10)
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
    unless current_user
      render :js => "alert('You must first log in for creating comment!');"
      return
    end
    create_post_score
    create_post_comment
    @comments = @post.comments
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

  def create_post_score
    if params[:rating].present? && !@post.has_rating_from(@user)
      @post.scores.create(:user_id => @user.id, :value => params[:rating])
    end
  end

  def create_post_comment
    @post.comments.create(:user_id => @user.id, :body => params[:body])
  end
end
