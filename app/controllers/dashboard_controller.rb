class DashboardController < ApplicationController
  def index
    @posts = Post.all.paginate(:page => params[:page], :per_page => 10)
    render 'public_dashboard' and return unless current_user
    render 'private_dashboard'
  end

  def users
    @users = User.all
  end
end
