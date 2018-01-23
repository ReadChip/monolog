class SitesController < ApplicationController
  def top
    if logged_in?
      @user = current_user
      @micropost  = @user.microposts.build
      @feed_items = Array.new

      if @user.usermicro.nil?
        micro = Usermicro.create(user_id: @user.id) 
        m_new = Micropost.offset( rand(Micropost.count) ).first
        micro.micro1 = m_new.id
      else
        micro = @user.usermicro
      end

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
      feed_cnt = Array.new
      micro = @user.usermicro

      feed_cnt << micro.micro10 = micro.micro9
      feed_cnt << micro.micro9 = micro.micro8
      feed_cnt << micro.micro8 = micro.micro7
      feed_cnt << micro.micro7 = micro.micro6
      feed_cnt << micro.micro6 = micro.micro5
      feed_cnt << micro.micro5 = micro.micro4
      feed_cnt << micro.micro4 = micro.micro3
      feed_cnt << micro.micro3 = micro.micro2
      feed_cnt << micro.micro2 = micro.micro1
      micro.save

      feed_cnt << micro.micro1
      feed_cnt.compact!

      m_new = Micropost.offset( rand(Micropost.count) ).first
      feed_cnt[0] = (m_new.id)
      cnt = 0
      block = current_user.blockers.ids

      while feed_cnt.uniq.count != feed_cnt.count && cnt <= 500  do
        m_new = Micropost.offset( rand(Micropost.count) ).first
        feed_cnt[0] = (m_new.id)
        cnt = cnt + 1
        while block.include?(m_new.id) do
          m_new = Micropost.offset( rand(Micropost.count) ).first
          feed_cnt[0] = (m_new.id)
        end
      end

      micro.micro1 = m_new.id
      micro.save

      @item = m_new.id

    end
  end
end
