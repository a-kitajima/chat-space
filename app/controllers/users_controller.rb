class UsersController < ApplicationController
  before_action :move_to_sign_in

  def edit
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

  def move_to_sign_in
    unless user_signed_in?
      flash[:alert] = "ログインまたは登録が必要です。"
      redirect_to new_user_session_path
    end
  end
end
