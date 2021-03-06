class MessagesController < ApplicationController
  before_action :move_to_sign_in

  def index
    @groups = current_user.groups
    @group = Group.find(params[:group_id])
    @messages = @group.messages
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    respond_to do |format|
      if @message.save
        format.json
      else
        format.json { redirect_to group_messages_path }
      end
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id, group_id: params[:group_id])
  end

  def move_to_sign_in
    unless user_signed_in?
      flash[:alert] = "ログインまたは登録が必要です。"
      redirect_to new_user_session_path
    end
  end
end
