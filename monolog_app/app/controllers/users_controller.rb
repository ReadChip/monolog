class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :liking, :likers]
  before_action :correct_user,   only: [:edit, :update, :show]
  before_action :admin_user,     only: [:destroy, :all_users]
  

  def index 
      @user = current_user
      @micropost  = current_user.microposts.build
      @feed_items = current_user.myfeed.paginate(page: params[:page])
  end

  def all_users
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts

  end

  def new
    @user = User.new
    render layout: 'capplication'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = @user.email + "に確認メールを送りました。"
      redirect_to root_url
    else
      render 'new', layout: 'capplication'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報の更新に成功しました。"
      redirect_to @user
    else
      render 'show'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def liking
    @title = "Liking"
    @user  = User.find(params[:id])
    @users = @user.liking.paginate(page: params[:page])
    render 'show_like'
  end

  def likers
    @title = "Likers"
    @user  = User.find(params[:id])
    @users = @user.likers.paginate(page: params[:page])
    render 'show_like'
  end

  private

    def user_params
      params.require(:user).permit(:user_id, :name, :email, :password, :profile,
                                   :picture,:password_confirmation)
    end


# beforeアクション

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end