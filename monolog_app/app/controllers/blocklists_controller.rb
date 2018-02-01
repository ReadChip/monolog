class BlocklistsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find(params[:blocked_id])
    current_user.block(user)
    redirect_to params[:url]
  end

  def destroy
    user = Blocklist.find_by(blocker_id: current_user,blocked_id: params[:blocked_id])
    current_user.unblock(user)
    redirect_to params[:url]
  end
end
