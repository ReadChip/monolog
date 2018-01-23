class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :update, :destroy,:show,
                                        :liking, :likers,:blocking, :blockers]
#  before_action :correct_user,   only: [:edit]
  before_action :admin_user,     only: [:destroy, :all_users]
  before_action :link_only,     only: [:new, :create, :update, :destroy,
                                      :liking, :likers,:show]
  

  def index 
      @user = current_user
      @micropost  = current_user.microposts.build
      @feed_items = current_user.myfeed.paginate(page: params[:page],per_page: 10)
  end

  def all_users
    @users = User.all
  end

  def show
    @user = User.find_by(user_id: params[:user_id])
    if current_user?(@user)
      redirect_to(users_path)
    else
      @user = current_user
    end
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

  def liking
    @title = "Liking"
    @user  = User.find_by(user_id: params[:user_id])
    @users = @user.liking.paginate(page: params[:page])
    render 'show_like'
  end

  def likers
    @title = "Likers"
    @user  = User.find_by(user_id: params[:user_id])
    @users = @user.likers.paginate(page: params[:page])
    render 'show_like'
  end

  def blocking
    @title = "Blocking"
    @user  = User.find(params[:id])
    @users = @user.blocking.paginate(page: params[:page])
    render 'show_block'
  end

  def blockers
    @title = "Blockers"
    @user  = User.find(params[:id])
    @users = @user.blockers.paginate(page: params[:page])
    render 'show_block'
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