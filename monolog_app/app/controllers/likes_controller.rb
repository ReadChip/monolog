class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find(params[:liked_id])
    current_user.like(user)
    redirect_to user
  end

  def destroy
    user = Like.find(params[:id]).liked
    current_user.unlike(user)
    redirect_to user
  end
end