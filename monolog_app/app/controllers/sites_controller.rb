class SitesController < ApplicationController
  def top
    if logged_in?
      @user = current_user
      @micropost  = current_user.microposts.build
      @feed_items = Array.new
      while @feed_items.count <= 9 do
        @feed_items << Micropost.offset( rand(Micropost.count) ).first
        @feed_items.uniq!
      end
    else
          render layout: 'capplication'
    end
  end
end
