class SitesController < ApplicationController
  def top
    if logged_in?
      @user = current_user
      @micropost  = @user.microposts.build
      @feed_items = Array.new

      micro = @user.usermicro
      micro = Usermicro.create(user_id: @user) if micro.nil?


      @feed_items = micro.micro1,micro.micro2,micro.micro3,micro.micro4,micro.micro5,
                     micro.micro6,micro.micro7,micro.micro8,micro.micro9,micro.micro10
      @feed_items.compact!


    else
          render layout: 'capplication'
    end
  end

  def refresh
    if logged_in?
      @user = current_user
      @micropost  = @user.microposts.build
      micro = @user.usermicro
      /Micropost.update/
      @feed_items = Array.new

        micro.micro10 = micro.micro9
        micro.micro9 = micro.micro8
        micro.micro8 = micro.micro7
        micro.micro7 = micro.micro6
        micro.micro6 = micro.micro5
        micro.micro5 = micro.micro4
        micro.micro4 = micro.micro3
        micro.micro3 = micro.micro2
        micro.micro2 = micro.micro1
        micro.save

        @feed_items = micro.micro2,micro.micro3,micro.micro4,micro.micro5,
                       micro.micro6,micro.micro7,micro.micro8,micro.micro9,micro.micro10

        @feed_items.compact!
        m_new = Micropost.offset( rand(Micropost.count) ).first
        @feed_items << m_new.id

        cnt = 0

      while @feed_items.uniq.count != @feed_items.count && cnt <= 500 do
        @feed_items.uniq!
        m_new = Micropost.offset( rand(Micropost.count) ).first
        @feed_items << m_new.id
        cnt = cnt + 1
      end

      micro.micro1 = @feed_items.last
      micro.save

      @feed_items.unshift(@feed_items.pop)
      end
  end
  
end
