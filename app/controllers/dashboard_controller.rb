class DashboardController < ApplicationController
  def index
    render 'public_dashboard' and return unless current_user
    render 'private_dashboard'
  end

  def users
    @users = User.all
  end
end
