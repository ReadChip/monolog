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

      @block = Array.new
      @block << 999999
      current_user.blocking.each do |item|
        @block << item.id
      end
      
      save = Micropost.where("user_id NOT IN(?)",@block)
      m_new = save.offset( rand(save.count) ).first
      cnt = 0

      while feed_cnt.include?("#{m_new.id}") && cnt <= 500  do
        m_new = save.offset( rand(save.count) ).first
        cnt = cnt + 1
      end

      micro.micro1 = m_new.id
      micro.save

      @item = m_new.id

    end
  end
end
