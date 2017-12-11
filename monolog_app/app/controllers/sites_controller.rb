class SitesController < ApplicationController
  def top
    if logged_in?
      @user = current_user
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])

 /#     @feed_items = Array.new
      cnt = 0
      while @feed_items.count <= 9 && cnt <= 50 do
        @feed_items << Micropost.offset( rand(Micropost.count) ).first
        @feed_items.uniq!
        cnt = cnt + 1
      end
/
    else
          render layout: 'capplication'
    end
  end
end
