class MessagesController < ApplicationController
  before_action :move_to_sign_in, only: :index
  
  def index
    
  end

  private
  def move_to_sign_in
    unless user_signed_in?
      flash[:alert] = "ログインまたは登録が必要です。"
      redirect_to new_user_session_path
    end
  end
end
