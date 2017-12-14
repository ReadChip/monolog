class SitesController < ApplicationController
  def top
    if logged_in?
      @user = current_user
      @micropost  = current_user.microposts.build
      @feed_items = Array.new
      micro = current_user.usermicros
      m_new = Micropost.offset( rand(Micropost.count) ).first

/      while m_new.id != m_old && cnt <= 50 do
        m_new = Micropost.offset( rand(Micropost.count) ).first
        cnt = cnt + 1
      end/

        micro.first.micro10 = micro.first.micro9
        micro.first.micro9 = micro.first.micro8
        micro.first.micro8 = micro.first.micro7
        micro.first.micro7 = micro.first.micro6
        micro.first.micro6 = micro.first.micro5
        micro.first.micro5 = micro.first.micro4
        micro.first.micro4 = micro.first.micro3
        micro.first.micro3 = micro.first.micro2
        micro.first.micro2 = micro.first.micro1
        micro.first.save


      unless micro.first.micro2.nil?
        @feed_items << Micropost.find_by(id: micro.first.micro2)
      unless micro.first.micro3.nil?
        @feed_items << Micropost.find_by(id: micro.first.micro3)
      unless micro.first.micro4.nil?
        @feed_items << Micropost.find_by(id: micro.first.micro4)
      unless micro.first.micro5.nil?
        @feed_items << Micropost.find_by(id: micro.first.micro5)
      unless micro.first.micro6.nil?
        @feed_items << Micropost.find_by(id: micro.first.micro6)
      unless micro.first.micro7.nil?
        @feed_items << Micropost.find_by(id: micro.first.micro7)
      unless micro.first.micro8.nil?
        @feed_items << Micropost.find_by(id: micro.first.micro8)
      unless micro.first.micro9.nil?
        @feed_items << Micropost.find_by(id: micro.first.micro9)
      unless micro.first.micro10.nil?
        @feed_items << Micropost.find_by(id: micro.first.micro10)
      end end end end end end end end end

        @feed_items << m_new

        cnt = 0

      while @feed_items.uniq.count != @feed_items.count && cnt <= 50 do
        @feed_items.uniq!
        @feed_items << Micropost.offset( rand(Micropost.count) ).first
        cnt = cnt + 1
      end

      micro.first.micro1 = @feed_items.last.id
      micro.first.save

      @feed_items.unshift(@feed_items.pop)

      @feed_items.compact!
    


 /     @feed_items = current_user.feed.paginate(page: params[:page])

      @feed_items = Array.new
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
