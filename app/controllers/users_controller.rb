class UsersController < ApplicationController
  def index
    @users = User.all
    @friends = current_user.friends
    @pending_requests = current_user.pending_requests
    @friend_requests = current_user.received_requests
  end

  def show
    @user = User.find(params[:id])
  end
end
