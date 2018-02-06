class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :update, :destroy,:show,:edit,
                                        :mypage,:liking, :likers,:bell]
#  before_action :correct_user,   only: [:edit]
  before_action :admin_user,     only: [:destroy, :all_users]
  before_action :link_only,     only: [:new, :create, :update, :destroy, :show]
  

  def index 
      @user = current_user
      @micropost  = current_user.microposts.build
      @feed_items = current_user.myfeed.paginate(page: params[:emit],per_page: 10)
      @users = @user.blocking.paginate(page: params[:block],per_page: 30)
      @like_items = current_user.liking.paginate(page: params[:like],per_page: 10)

  end

  def all_users
    @users = User.all
  end

  def show
    @user = User.find_by(user_id: params[:user_id])
    redirect_to(users_path) if current_user?(@user)
  end

  def edit
    @user = User.find_by(id: current_user)
    @microposts = @user.microposts
  end

  def new
    @user = User.new
    render layout: 'capplication'
  end

  def create
    @user = User.new(user_params)
    unless params[:cancel]
      if verify_recaptcha(model: @user) &&  @user.save
        @user.send_activation_email
        flash[:info] = @user.email + "に確認メールを送りました。"
        redirect_to root_url
      else
        render 'new', layout: 'capplication'
      end
    else
      redirect_to root_url, layout: 'capplication'
    end
  end

  def update
    @user = User.find_by(id: current_user)
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報の更新に成功しました。"
      redirect_to edit_path
    else
      
      redirect_to edit_path
    end
  end

  def destroy
    User.find_by(id: params[:user_id]).destroy
    flash[:success] = "User deleted"
    redirect_to all_path
  end

  def mypage
    if params[:emit]
      render 'myemit',{hoge: "emit"}
    elsif params[:like]
      render 'mylike',{hoge: "like"}
    else
      render 'myblock',{hoge: "block"}
    end
  end

  def bell    
    micros = current_user.microposts
    @like_id = Array.new
    micros.each do |micro|
      @like_id << micro.passive_likes unless micro.passive_likes.map(&:id) == []
    end
    @like_id.flatten!
    @like_id.sort!{|a, b| b <=> a }

    current_user.time = DateTime.now
    current_user.save
  end
  

  private

    def user_params
      params.require(:user).permit(:user_id, :name, :email, :password, :profile,
                                   :picture,:password_confirmation)
    end


# beforeアクション

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find_by(user_id: params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    # urlの直打ち対策
    def link_only
      redirect_to(root_url) if request.referer.nil?
    end
end