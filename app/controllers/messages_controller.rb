class MessagesController < ApplicationController
  def index
    @groups = current_user.groups
    @group = Group.find(params[:group_id])
    @messages = @group.messages
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    unless @message.body.empty? && @message.image.file.nil?
      @message.save
    else
      flash[:alert] = "メッセージを入力してください。"
    end
    redirect_to group_messages_path
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id, group_id: params[:group_id])
  end
end
