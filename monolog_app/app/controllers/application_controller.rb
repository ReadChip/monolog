class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception

#  rescue_from ActiveRecord::RecordNotFound, with: :render_404
#  rescue_from ActionController::RoutingError, with: :render_404
#  rescue_from Exception, with: :render_500

#  def render_404(exception = nil)
#   if exception
#      logger.info "Rendering 404 with exception: #{exception.message}"
#    end
#    render template: "errors/error_404", status: 404, layout: 'application'
#  end

#  def render_500(exception = nil)
#    if exception
#      logger.info "Rendering 500 with exception: #{exception.message}"
#    end
#    render template: "errors/error_500", status: 500, layout: 'application'
#  end 

   private

    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
end
