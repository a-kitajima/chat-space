class MessagesController < ApplicationController
  def index
    @groups = current_user.groups
    @messages = Message.all
    @group = Group.find(params[:group_id])
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.body || @message.image
      @message.save
      redirect_to group_messages_path
    else
      flash[:alert] = "メッセージを入力してください。"
      render action: :index
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id, group_id: params[:group_id])
  end
end
