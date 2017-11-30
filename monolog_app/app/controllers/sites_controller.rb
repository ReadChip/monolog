class SitesController < ApplicationController
  def top
    if logged_in?
      @user = current_user
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    else
          render layout: 'capplication'
    end
  end
end
