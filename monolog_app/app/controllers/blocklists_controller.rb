class BlocklistsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find_by(user_id: params[:blocked_id])
    current_user.block(user)
    redirect_to params[:url]
  end

  def destroy
    user = Blocklist.find(params[:id]).blocked
    current_user.unblock(user)
    redirect_to params[:url]
  end
end
