class SessionsController < ApplicationController

  def new
    render layout: 'capplication'
  end

  def create
    user = User.find_by(user_id: params[:session][:user_id])
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or root_url
      else
        message  = "アカウントが有効化されていません。 "
        message += "メールを確認して有効化のためのリンクを開いてください。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'ユーザーIDまたはパスワードが間違っています。'
      render 'new', layout: 'capplication'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end