class SitesController < ApplicationController
  def top
    if logged_in?
      @user = current_user
      @micropost  = @user.microposts.build
      @feed_items = Array.new

      micro = @user.usermicros.first

      if micro.nil?
        micro = @user.usermicros.new
        micro = @user.usermicros.first
        micro.save
      end


      @feed_items << micro.micro1
      @feed_items << micro.micro2
      @feed_items << micro.micro3
      @feed_items << micro.micro4
      @feed_items << micro.micro5
      @feed_items << micro.micro6
      @feed_items << micro.micro7
      @feed_items << micro.micro8
      @feed_items << micro.micro9
      @feed_items << micro.micro10
      @feed_items.compact!


    else
          render layout: 'capplication'
    end
  end

  def refresh
    if logged_in?
      @user = current_user
      @micropost  = @user.microposts.build
      micro = @user.usermicros.first
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

        @feed_items << micro.micro2
        @feed_items << micro.micro3
        @feed_items << micro.micro4
        @feed_items << micro.micro5
        @feed_items << micro.micro6
        @feed_items << micro.micro7
        @feed_items << micro.micro8
        @feed_items << micro.micro9
        @feed_items << micro.micro10

        @feed_items.compact!
        m_new = Micropost.offset( rand(Micropost.count) ).first
        @feed_items << m_new.id

        cnt = 0

      while @feed_items.uniq.count != @feed_items.count && cnt <= 50 do
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
