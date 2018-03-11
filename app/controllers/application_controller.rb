class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def login_required
    redirect_to(login_path, alert: t("login_required")) unless current_user
  end

  def user_not_authorized
    redirect_to(root_path, alert: t("unauthorized"))
  end
end
