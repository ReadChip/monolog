class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find(params[:liked_id])
    current_user.like(user)
    redirect_to root_url
  end

  def destroy
    user = Like.find_by(user_id: params[:user_id]).liked
    current_user.unlike(user)
    redirect_to user
  end
end