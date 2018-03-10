class LoginController < ApplicationController
  before_action :only_for_anonymous, except: :destroy

  def new; end

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: t(".success")
    else
      redirect_to login_path, alert: t(".error")
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: t(".success")
  end

  private

  def only_for_anonymous
    redirect_to root_path if session[:user_id]
  end
end
