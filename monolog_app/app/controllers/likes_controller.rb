class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @micro = Micropost.find(params[:liked_id])
    current_user.like(@micro)

/#    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end#/
  end

  def destroy
    @user = Like.find_by(liker_id: current_user,liked_id: params[:liked_id])
    current_user.unlike(@user)

/#    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end#/
  end
end