class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find(params[:liked_id])
    current_user.like(user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    user = Like.find_by(user_id: params[:user_id]).liked
    current_user.unlike(user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end